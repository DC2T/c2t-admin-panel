import 'package:admin/constants.dart';
import 'package:admin/models/Movies.dart';
import 'package:admin/models/Worker.dart';
import 'package:admin/screens/catalog/components/catalog_table.dart';
import 'package:admin/screens/reuseable/header.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>{
  int tabIndex = 0;

  var table_columns;
  var columns;

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              child: Builder(builder: (context) {
                TabController tabController =
                    DefaultTabController.of(context);
                tabController.animation;
                tabController.addListener(() {
                  if (!tabController.indexIsChanging) {
                    // Your code goes here.
                    // To get index of current tab use tabController.index
                    setState(() {
                      tabIndex = tabController.index;
                    });
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
                            tabs: tables
                                .map((tab) =>
                                    Tab(icon: tab['icon'], text: tab['name']))
                                .toList()),
                      ),
                      Container(
                        width: screenSize.width,
                        height: screenSize.height,
                        child: TabBarView(
                          children: tables.map((table) {
                            return CatalogTable(
                              table: table['name'],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
