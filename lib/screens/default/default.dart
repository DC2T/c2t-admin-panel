/*
This is default page
We used this pages first when we create new dart file
 */

import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Default Page',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          backgroundColor: primaryColor,
          brightness: Brightness.dark,
        ),
        body: Container(
          child: Center(
            child: Text('This is Default Page'),
          ),
        )
    );
  }
}
