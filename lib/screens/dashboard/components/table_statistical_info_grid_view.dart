import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'table_statistical_info_view.dart';

class TableStatisticalInfoGridView extends StatelessWidget {
  const TableStatisticalInfoGridView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        primary: false,
        crossAxisCount: (MediaQuery.of(context).size.width < 650) ? 1 : 2,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        shrinkWrap: true,
        children: <Widget>[
          TableStatisticalInfoView(title: 'Top items', iconTitle: Icons.bar_chart,),
          TableStatisticalInfoView(title: 'Latest items', iconTitle: Icons.grid_3x3,),
          TableStatisticalInfoView(title: 'Top items', iconTitle: Icons.bar_chart,),
          TableStatisticalInfoView(title: 'Latest items', iconTitle: Icons.grid_3x3,),
          TableStatisticalInfoView(title: 'Top items', iconTitle: Icons.bar_chart,),
          TableStatisticalInfoView(title: 'Latest items', iconTitle: Icons.grid_3x3,),
        ],
      ),
    );
  }
}
