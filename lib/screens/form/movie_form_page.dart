import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/reuseable/header.dart';
import 'package:admin/screens/form/components/movie_form.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieFormPage extends StatefulWidget {
  @override
  _MovieFormPageState createState() => _MovieFormPageState();
}

class _MovieFormPageState extends State<MovieFormPage> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(title: "Modifier Movie",),
              SizedBox(height: defaultPadding * 2),
              MovieForm()
            ],
          ),
        ),
      );
  }
}
