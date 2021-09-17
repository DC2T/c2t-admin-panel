import 'package:admin/screens/reuseable/text_form_search.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:file_picker/file_picker.dart';

class MovieFormTab extends StatefulWidget {
  var data;

  MovieFormTab({this.data});

  @override
  _MovieFormTabState createState() => _MovieFormTabState();
}

class _MovieFormTabState extends State<MovieFormTab> {
  String img = '';
  String title = '';
  DateTime pickedDate;

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtSubTitle = TextEditingController();
  TextEditingController txtStoryLine = TextEditingController();
  TextEditingController txtTrailer = TextEditingController();
  TextEditingController txtVoted = TextEditingController();
  TextEditingController txtViews = TextEditingController();
  TextEditingController txtEpisodes = TextEditingController();
  TextEditingController txtRuntime = TextEditingController();
  TextEditingController txtReleaseDate = TextEditingController();
  TextEditingController txtReleaseYear = TextEditingController();
  TextEditingController txtFrom = TextEditingController();
  TextEditingController txtForm = TextEditingController();
  TextEditingController txtCategories= TextEditingController();
  TextEditingController txtCountries = TextEditingController();
  TextEditingController txtDirectors = TextEditingController();
  TextEditingController txtLanguages = TextEditingController();

  final _multiSelectKey = GlobalKey<FormFieldState>();

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    if (widget.data != null) {
      txtTitle.text = widget.data['title'];
      txtSubTitle.text = widget.data['subTitle'];
      txtStoryLine.text = widget.data['storyline'];
      txtRuntime.text = widget.data['runtime'];
      txtReleaseDate.text = widget.data['releaseDate'];
      txtReleaseYear.text = widget.data['releaseYear'];
      txtFrom.text = widget.data['from'];
      txtForm.text = widget.data['form']? 'Series': 'Odds';
      txtVoted.text = widget.data['pointVoted'].toString();
      txtEpisodes.text = widget.data['nEpisodes'].toString();
      txtViews.text = widget.data['views'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height * 0.55,
                            margin: EdgeInsets.only(right: defaultPadding, top: defaultPadding),
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius)),
                            child: Center(
                              child: Text("Upload Image"),
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
                        Container(
                          margin: EdgeInsets.only(right: defaultPadding, top: defaultPadding),
                          child: TextEditFormFill(
                            color: Colors.white,
                            labelText: 'Form',
                            backgroundColor: bgColor,
                            readOnly: true,
                            dropdownBox: true,
                            controller: txtForm,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: screenSize.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextEditFormFill(
                                  color: Colors.white,
                                  labelText: 'Title',
                                  backgroundColor: bgColor,
                                  controller: txtTitle,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 2,
                                child: TextEditFormFill(
                                  controller: txtSubTitle,
                                  color: Colors.white,
                                  labelText: 'Subtitle',
                                  backgroundColor: bgColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          TextEditFormFill(
                              controller: txtStoryLine,
                              labelText: 'Storyline',
                              height: screenSize.height * 0.29,
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
                                child: TextEditFormFill(
                                  controller: txtEpisodes,
                                  color: Colors.white,
                                  labelText: 'Episodes',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: TextEditFormFill(
                                  controller: txtFrom,
                                  color: Colors.white,
                                  labelText: 'From',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: TextEditFormFill(
                                  controller: txtVoted,
                                  color: Colors.white,
                                  labelText: 'Votes',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: TextEditFormFill(
                                  controller: txtViews,
                                  color: Colors.white,
                                  labelText: 'Views',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                child: TextEditFormFill(
                                  controller: txtRuntime,
                                  color: Colors.white,
                                  labelText: 'Runtime',
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
                                  child: TextEditFormFill(
                                      controller: txtReleaseDate,
                                      labelText: 'Release Date',
                                      backgroundColor: bgColor,
                                      color: Colors.white,
                                      readOnly: true,
                                      onTap: (){
                                        _pickDate();
                                      }
                                  ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 2,
                                child: TextEditFormFill(
                                  controller: txtReleaseYear,
                                  color: Colors.white,
                                  labelText: 'Release Year',
                                  backgroundColor: bgColor,
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 6,
                                child: TextEditFormFill(
                                  controller: txtTrailer,
                                  color: Colors.white,
                                  labelText: 'Trailer',
                                  backgroundColor: bgColor,
                                  width: (MediaQuery.of(context).size.width),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtCategories,
                      dropdownSearch: true,
                      color: Colors.white,
                      labelText: 'Categories',
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtDirectors,
                      dropdownSearch: true,
                      color: Colors.white,
                      labelText: 'Directors',
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtLanguages,
                      dropdownSearch: true,
                      color: Colors.white,
                      labelText: 'Languages',
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtCountries,
                      dropdownSearch: true,
                      color: Colors.white,
                      labelText: 'Countries',
                      backgroundColor: bgColor,
                    ),
                  ),
                ],
              ),
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
        txtReleaseDate.text = formatDate(pickedDate);
      });
    }
    ;
  }
}
