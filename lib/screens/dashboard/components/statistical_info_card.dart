import 'package:admin/constants.dart';
import 'package:admin/models/SimpleStatistical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticalInfoCard extends StatelessWidget {
  const StatisticalInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final SimpleStatisticalInfo info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            info.title!,
            softWrap: true,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${info.total}",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white70),
                ),
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.15),
                  height: 20,
                  width: 24,
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
