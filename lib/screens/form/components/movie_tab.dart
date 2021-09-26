import 'package:admin/models/Movies.dart';
import 'package:admin/screens/reuseable/text_form_customize.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  final txtTitle = TextEditingController();
  final txtSubTitle = TextEditingController();
  final txtStoryLine = TextEditingController();
  final txtTrailer = TextEditingController();
  final txtVoted = TextEditingController();
  final txtViews = TextEditingController();
  final txtEpisodes = TextEditingController();
  final txtRuntime = TextEditingController();
  final txtReleaseDate = TextEditingController();
  final txtReleaseYear = TextEditingController();
  final txtFrom = TextEditingController();
  final txtForm = TextEditingController();
  final txtCategories = TextEditingController();
  final txtCountries = TextEditingController();
  final txtDirectors = TextEditingController();
  final txtCasts = TextEditingController();
  final txtLanguages = TextEditingController();

  var form = [
    {
      'name': 'Odds',
      'value': false,
    },
    {
      'name': 'Series',
      'value': true,
    }
  ];

  Map episode = {};

  var episodes = [];

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
      txtForm.text = widget.data['form'] ? 'Series' : 'Odds';
      txtVoted.text = widget.data['pointVoted'].toString();
      txtEpisodes.text = widget.data['nEpisodes'].toString();
      txtViews.text = widget.data['views'].toString();
      episodes = widget.data['fIds'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var _crossAxisSpacing = defaultPadding;
    var _crossAxisCount = 10;
    var _width =
        (screenSize.width * 0.6 - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
            _crossAxisCount;
    var cellHeight = 50;
    var _aspectRatio = _width / cellHeight;
    print('${_aspectRatio}, ${_width}');
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
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.55,
                          margin: EdgeInsets.only(
                              right: defaultPadding, top: defaultPadding),
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text("Upload Image"),
                              ),
                              SizedBox(
                                height: defaultPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buttonDefault(
                                      leading: Icon(Icons.upload_file),
                                      onTap: () {
                                        pickFile();
                                      }),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  buttonDefault(
                                      leading: Icon(Icons.link),
                                      onTap: () async {}),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: defaultPadding, top: defaultPadding),
                          child: TextEditFormFill(
                            color: Colors.white,
                            labelText: 'Form',
                            backgroundColor: bgColor,
                            readOnly: true,
                            data: form,
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
                                  labelText: 'Sub Title',
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
                              inputType: TextInputType.multiline,
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
                                  inputType: TextInputType.number,
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
                                  inputType: TextInputType.number,
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
                                  inputType: TextInputType.number,
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
                                    onTap: () {
                                      _pickDate();
                                    }),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 2,
                                child: TextEditFormFill(
                                  inputType: TextInputType.number,
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
                      color: Colors.white,
                      labelText: 'Categories',
                      dropdownBox: true,
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtDirectors,
                      color: Colors.white,
                      labelText: 'Directors',
                      dropdownBox: true,
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtCasts,
                      color: Colors.white,
                      labelText: 'Casts',
                      dropdownBox: true,
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtLanguages,
                      color: Colors.white,
                      labelText: 'Languages',
                      dropdownBox: true,
                      backgroundColor: bgColor,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: TextEditFormFill(
                      controller: txtCountries,
                      color: Colors.white,
                      labelText: 'Countries',
                      dropdownBox: true,
                      backgroundColor: bgColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      ),
                      child: GridView.builder(
                          itemCount: episodes.length + 1,
                          padding: EdgeInsets.all(defaultPadding),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            crossAxisCount: _crossAxisCount,
                            childAspectRatio: _aspectRatio,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  _addEpisode();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(
                                        defaultBorderRadius),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[400],
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                ),
                                child: Center(child: Text(episodes[index-1]['index'].toString())),
                              ),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: null,
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

  _addEpisode() {
    final txtEpNum = TextEditingController();
    final txtEpFile = TextEditingController();
    final txtEpGgDrive = TextEditingController();
    final txtEpHydrax = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) {
          List<Map<String, dynamic>> servers = [
            {'name': 'fId', 'text_edit_controller': txtEpGgDrive},
            {'name': 'hydrax', 'text_edit_controller': txtEpHydrax}
          ];
          return AlertDialog(
            titlePadding: const EdgeInsets.all(8.0),
            contentPadding: const EdgeInsets.all(8.0),
            title: Text('Add Episode'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                children: [
                  TextEditFormFill(
                    inputType: TextInputType.number,
                    controller: txtEpNum,
                    color: Colors.white,
                    labelText: 'Episode',
                    backgroundColor: bgColor,
                  ),
                  SizedBox(height: defaultPadding,),
                  TextEditFormFill(
                    controller: txtEpFile,
                    color: Colors.white,
                    labelText: 'Upload File',
                    backgroundColor: bgColor,
                    readOnly: true,
                    onTap: (){
                      pickFile();
                    },
                    suffixIcon: Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF007EE5).withOpacity(0.1),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Icon(
                        Icons.upload_file,
                        color: Color(0xFF007EE5),
                        size: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding,),
                  TextEditFormFill(
                    controller: txtEpGgDrive,
                    color: Colors.white,
                    labelText: 'Google Drive',
                    backgroundColor: bgColor,
                    suffixIcon: Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFA113).withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/google_drive.svg',
                        color: Color(0xFFFFA113),
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding,),
                  TextEditFormFill(
                    controller: txtEpHydrax,
                    color: Colors.white,
                    labelText: 'Hydrax',
                    backgroundColor: bgColor,
                  ),
                ],
              ),
            ),
            actions: [
              buttonDefault(
                label: 'Add',
                onTap: (){
                  episode['index'] = txtEpNum.text;
                  episode['servers'] = servers.map((server) {
                    return {
                      'label': server['name'],
                      'video': server['text_edit_controller'].text,
                    };
                  });
                  episodes.add(episode);
                  print(episodes.toString());
                  Navigator.pop(ctx);
                  setState(() {

                  });
                }
              )
            ],
          );
        });
  }
}
