import 'dart:io';

import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'movie_tab.dart';
import 'server_tab.dart';

class MovieForm extends StatefulWidget {
  const MovieForm({Key key}) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
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
            Divider(height: 2, color: Colors.white),
            Container(
              width: screenSize.width,
              height: screenSize.height,
              child: TabBarView(children: [
                MovieTab(),
                ServerTab(),
              ]),
            ),
          ],
        ),
      ),
    );
    //return MovieTab(screenSize: screenSize);
  }
}
