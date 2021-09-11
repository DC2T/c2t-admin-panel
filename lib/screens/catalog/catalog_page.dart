import 'package:admin/constants.dart';
import 'package:admin/models/Movies.dart';
import 'package:admin/models/Worker.dart';
import 'package:admin/screens/catalog/components/catalog_table.dart';
import 'package:admin/screens/reuseable/header.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>
    with SingleTickerProviderStateMixin {

  int page = 1;
  int perPage = 20;
  int tabIndex = 0;

  var table_columns = Movie.table_columns();
  var columns = Movie.columns();

  var data;

  final List<Map<String, dynamic>> tables = <Map<String, dynamic>>[
    {'name': 'Movie', 'icon': Icon(Icons.movie_creation_outlined)},
    {'name': 'Worker', 'icon':Icon(Icons.cloud_outlined)}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData(tables[tabIndex]['name']);

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _fetchData(model) async {
    print('${tabIndex.toString()}, ${model}');
    switch (model) {
      case 'Movie':
        table_columns = Movie.table_columns();
        columns = Movie.columns();
        data = (await Movie.find())['data'];
        break;
      case 'Worker':
        table_columns = Worker.table_columns();
        columns = Worker.columns();
        data = (await Worker.find())['data'];
        break;
      default:
        break;
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Catalog',
            ),
            SizedBox(height: defaultPadding),
            DefaultTabController(
              length: tables.length,
              initialIndex: tabIndex,
              child: Builder(builder: (BuildContext context) {
                final TabController tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  if (!tabController.indexIsChanging) {
                    // Your code goes here.
                    // To get index of current tab use tabController.index
                    tabIndex = tabController.index;
                    _fetchData(tables[tabIndex]['name']);
                  }
                });
                  return Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: 55,
                          child: TabBar(
                            indicatorColor: Colors.white,
                            tabs: tables.map((tab) => Tab(icon: tab['icon'], text: tab['name'])).toList()
                          ),
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height,
                          child: TabBarView(
                            children: tables
                                .map(
                                  (table) => CatalogTable(table_columns: table_columns, columns: columns, data: data,),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: secondaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buttonDefault(
                      label: 'Pre',
                      leading: Icon(Icons.arrow_back_ios),
                      onTap: _preNav()),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  buttonDefault(
                      label: 'Next',
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: _nextNav()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _preNav() {
    setState(() {
      page -= 1;
    });
  }

  _nextNav() {
    setState(() {
      page += 1;
    });
  }
}
