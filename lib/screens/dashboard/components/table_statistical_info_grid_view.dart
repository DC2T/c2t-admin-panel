import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'table_statistical_info_view.dart';

class TableStatisticalInfoGridView extends StatelessWidget {
  const TableStatisticalInfoGridView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      crossAxisSpacing: defaultPadding,
      mainAxisSpacing: defaultPadding,
      children: <Widget>[
        Expanded(child: TableStatisticalInfoView(title: 'Top items', iconTitle: Icons.bar_chart,)),
        Expanded(child: TableStatisticalInfoView(title: 'Latest items', iconTitle: Icons.grid_3x3,)),
      ],
    );
  }
}
