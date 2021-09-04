import 'package:admin/constants.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:flutter/material.dart';

class MovieForm extends StatefulWidget {
  const MovieForm({Key key}) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtTitle = TextEditingController();
    TextEditingController txtDescription = TextEditingController();
    TextEditingController txtReleaseYear = TextEditingController();
    TextEditingController txtRunningTimed = TextEditingController();
    TextEditingController txtQuality = TextEditingController();
    TextEditingController txtAge = TextEditingController();

    var screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 250,
                      height: 360,
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius)),
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textEditFormFill(context,
                              controller: txtTitle, hintText: 'Title'),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          textEditFormFill(context,
                              controller: txtDescription,
                              hintText: 'Description',
                              height: 100,
                              expands: true),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: textEditFormFill(context,
                                      controller: txtReleaseYear,
                                      hintText: 'Release year')),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                  child: textEditFormFill(context,
                                      controller: txtRunningTimed,
                                      hintText: 'Running timed')),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                  child: textEditFormFill(context,
                                      controller: txtQuality,
                                      hintText: 'Full HD')),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: textEditFormFill(context,
                                    hintText: 'Status'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: textEditFormFill(
                                context,
                                hintText: 'Country/Countries',
                              )),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                  child: textEditFormFill(
                                context,
                                hintText: 'Genre/Genres',
                              )),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                  child: textEditFormFill(
                                context,
                                hintText: 'Cast/Cast',
                              )),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                  child: textEditFormFill(
                                context,
                                hintText: 'Director/Directors',
                              )),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: textEditFormFill(
                                  context,
                                  hintText: 'Language/Languages',
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: textEditFormFill(
                                  context,
                                  hintText: 'Episodes',
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        'Odd',
                                      ),
                                      leading: Radio(
                                        value: false,
                                        activeColor: Color(0xFF6200EE),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        'Series',
                                      ),
                                      leading: Radio(
                                        value: false,
                                        activeColor: Color(0xFF6200EE),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
