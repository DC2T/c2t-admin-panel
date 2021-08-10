import 'package:admin/constants.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:flutter/material.dart';

class MovieForm extends StatelessWidget {
  const MovieForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(defaultBorderRadius)),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 250,
                      height: 360,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius)
                    ),
                  ),
                  SizedBox(width: defaultPadding,),
                  Container(
                    margin: EdgeInsets.only(right: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textEditFormFill(context, labelText: 'Title'),
                        SizedBox(height: defaultPadding,),
                        textEditFormFill(context, labelText: 'Description', height: 100, expands: true),
                        SizedBox(height: defaultPadding,),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [],
              ),
            ],
          ),
        ));
  }
}
