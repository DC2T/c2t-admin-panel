import 'package:admin/constants.dart';
import 'package:admin/models/SimpleStatistical.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/statistical_info_card.dart';
import 'package:flutter/material.dart';

class SimpleStatistical extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Responsive(
          mobile: StatisticalInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.9 : 1.1,
          ),
          tablet: StatisticalInfoCardGridView(
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.5 : 1.9,
          ),
          desktop: StatisticalInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.9 : 1.4,
          ),
        ),
      ],
    );
  }
}

class StatisticalInfoCardGridView extends StatelessWidget {
  const StatisticalInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoSimpleStatisticalInfo.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => StatisticalInfoCard(info: demoSimpleStatisticalInfo[index]),
    );
  }
}