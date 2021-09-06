import 'dart:io';

import 'package:admin/constants.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MovieForm extends StatefulWidget {
  const MovieForm({Key key}) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: 50,
              child: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(Icons.movie)),
                  Tab(icon: Icon(Icons.computer)),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.white),
            Expanded(
              child: Container(
                width: screenSize.width,
                child: TabBarView(children: [
                  Tab1(),
                  Icon(Icons.computer)
                ]),
              ),
            ),
          ],
        ),
      ),
    );
    //return MovieTab(screenSize: screenSize);
  }
}

class Tab1 extends StatefulWidget {
  Tab1({Key key}) : super(key: key);

  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.white,
       child: null,
    );
  }
}

class MovieTab extends StatefulWidget {
  const MovieTab({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  String img = '';
  String title = '';
  DateTime pickedDate;

  final _multiSelectKey = GlobalKey<FormFieldState>();

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.screenSize.width,
        padding: EdgeInsets.all(defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 300,
                      height: 510,
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius)),
                      child: Center(
                        child: Text("UPLOAD IMAGE"),
                      ),
                    ),
                    onTap: () async {
                      FilePickerResult result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        print(result.files.single.path);
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: textEditFormFill(
                                  context,
                                  color: Colors.white,
                                  labelText: 'TITLE',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 2,
                                child: textEditFormFill(
                                  context,
                                  color: Colors.white,
                                  labelText: 'SUBTITLE',
                                  backgroundColor: bgColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          textEditFormFill(context,
                              labelText: 'STORY LINE',
                              height: 150,
                              color: Colors.white,
                              backgroundColor: bgColor,
                              width: MediaQuery.of(context).size.width),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: textEditFormFill(
                                  context,
                                  color: Colors.white,
                                  labelText: 'FROM',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 3,
                                child: textEditFormFill(
                                  context,
                                  color: Colors.white,
                                  labelText: 'VIEWS',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 3,
                                child: textEditFormFill(
                                  context,
                                  color: Colors.white,
                                  labelText: 'VOTED',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                              "RELEASE DATE", 
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            borderRadius: BorderRadius.circular(
                                                defaultBorderRadius),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                                "${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}"),
                                            trailing: Icon(Icons.arrow_drop_down),
                                            onTap: _pickDate,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 2,
                                child: textEditFormFill(
                                  context,
                                  color: Colors.white,
                                  labelText: 'RELEASE YEAR',
                                  backgroundColor: bgColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          textEditFormFill(
                            context,
                            color: Colors.white,
                            labelText: 'TRAILER',
                            backgroundColor: bgColor,
                            width: (MediaQuery.of(context).size.width),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: defaultPadding,),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: MultiSelectInput(items: ["hehe", "haha"],),
                  ),
                  SizedBox(width: defaultPadding),
                ],
              ),
              SizedBox(height: defaultPadding),         
            ],
          ),
        ));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
    ;
  }
}
