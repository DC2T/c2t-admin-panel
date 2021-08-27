import 'package:admin/screens/reuseable/header.dart';
import 'package:admin/screens/tableMovie/components/pagination_table.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class TableMovie extends StatefulWidget {
  const TableMovie({Key key}) : super(key: key);

  @override
  _TableMovieState createState() => _TableMovieState();
}

class _TableMovieState extends State<TableMovie> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: "Catalog"),
            SizedBox(height: defaultPadding,),
            Divider(height: 1, color: Color.fromARGB(100, 255, 255, 255),),
            SizedBox(height: 20,),
            PaginationTable(),
          ],
        ),
      ),
    );
  }
}
