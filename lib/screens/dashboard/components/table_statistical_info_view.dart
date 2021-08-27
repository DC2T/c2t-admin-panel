import 'dart:ui';

import 'package:admin/controllers/ScreenController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class TableStatisticalInfoView extends StatelessWidget {
  final String title;
  final IconData iconTitle;
  const TableStatisticalInfoView({
    Key key,
    this.title,
    this.iconTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconTitle, size: 24.0,),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.refresh)
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  onPressed: () {
                    context.read<ScreenController>().controlScreen(screenName: 'Movie');
                  },
                  child: Text("See More"),
                ),
              )
            ],
          ),
          SizedBox(height: 5.0),
          Divider(height: 1.0),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            child: DataTable2(
              columnSpacing: (_size.width > 600 && _size.width < 1025)?defaultPadding * 2:defaultPadding * 4,
              minWidth: 400.0,
              columns: [
                DataColumn(
                  label: Text("Movie Name"),
                ),
                DataColumn(
                  label: Text("Rating"),
                ),
              ],
              rows: List.generate(
                5,
                (index) => index <= 4 ? recentFileDataRow(demoRecentFiles[index]) : null,
              ),
            ),
          ),
        ],
      ),

    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.title)),
      DataCell(Text(fileInfo.date)),
    ],
  );
}

