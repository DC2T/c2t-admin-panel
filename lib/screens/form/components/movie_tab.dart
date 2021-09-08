import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:file_picker/file_picker.dart';

class MovieTab extends StatefulWidget {

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
    var screenSize = MediaQuery.of(context).size;

    return Container(
        width: screenSize.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(defaultPadding),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.7,
                      margin: EdgeInsets.only(right: defaultPadding),
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
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height,
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