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
            Container(
              width: screenSize.width,
              //height: screenSize.height,
              padding: EdgeInsets.all(defaultPadding),
              child: TabBarView(
                children: [
                  MovieTab(
                    screenSize: screenSize,
                  ),
                  Icon(Icons.computer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //return MovieTab(screenSize: screenSize);
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

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}
class _MovieTabState extends State<MovieTab> {
  String img = '';
  String title = '';
  DateTime pickedDate;

  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.screenSize.width,
        //height: widget.screenSize.height,
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