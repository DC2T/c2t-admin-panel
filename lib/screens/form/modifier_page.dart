import 'package:admin/constants.dart';
import 'package:admin/screens/form/components/movie_tab.dart';
import 'package:admin/screens/form/components/server_tab.dart';
import 'package:admin/screens/reuseable/header.dart';
import 'package:flutter/material.dart';

class MovieFormPage extends StatefulWidget {
  @override
  _MovieFormPageState createState() => _MovieFormPageState();
}

class _MovieFormPageState extends State<MovieFormPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Modifier Movie',
            ),
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
                          Tab(icon: Icon(Icons.computer), text: "Server"),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      child: TabBarView(children: [
                        MovieFormTab(),
                        ServerFormTab(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
