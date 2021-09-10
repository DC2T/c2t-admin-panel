import 'package:admin/constants.dart';
import 'package:admin/screens/catalog/components/catalog_table.dart';
import 'package:admin/screens/reuseable/header.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: 'Catalog',),
            SizedBox(height: defaultPadding),
            DefaultTabController(
              length: 2,
              child: Container(
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
                        tabs: [
                          Tab(icon: Icon(Icons.movie), text: "Movie"),
                          Tab(icon: Icon(Icons.computer), text: "Worker"),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      child: TabBarView(children: [
                        CatalogTable('Movie'),
                        CatalogTable('Worker'),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: defaultPadding,),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: secondaryColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    buttonDefault(label: 'Pre', leading: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: defaultPadding,),
                    buttonDefault(label: 'Next', trailing: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
