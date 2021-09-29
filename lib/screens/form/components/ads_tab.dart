import 'package:flutter/material.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:admin/constants.dart';
import 'package:admin/models/Worker.dart';
import 'package:admin/screens/reuseable/text_form_customize.dart';

class AdsFormTab extends StatefulWidget {
  var data;

  AdsFormTab({this.data});

  @override
  _AdsFormTabState createState() => _AdsFormTabState();
}

class _AdsFormTabState extends State<AdsFormTab> {
  bool obscureText = false;
  bool isUpdate = false;
  TextEditingController txtFrom = TextEditingController();
  TextEditingController txtVideo = TextEditingController();
  TextEditingController txtStatus = TextEditingController();
  TextEditingController txtPos = TextEditingController();
  TextEditingController txtLeft = TextEditingController();
  TextEditingController txtRight = TextEditingController();
  TextEditingController txtTop = TextEditingController();
  TextEditingController txtBottom = TextEditingController();
  TextEditingController txtAlign = TextEditingController();
  TextEditingController txtPosition = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      txtFrom.text = widget.data['from'];
      txtVideo.text = widget.data['video'];
      txtPosition.text = widget.data['position'];
      txtStatus.text = widget.data['status'];

      setState(() {
        isUpdate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      width: screenSize.width,
      child: Column(children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextEditFormFill(
                controller: txtFrom,
                color: Colors.white,
                labelText: 'FROM',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 2,
              child: TextEditFormFill(
                controller: txtVideo,
                color: Colors.white,
                labelText: 'VIDEO',
                backgroundColor: bgColor,
              ),
            )
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextEditFormFill(
                controller: txtStatus,
                color: Colors.white,
                labelText: 'STATUS',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 2,
              child: TextEditFormFill(
                controller: txtPos,
                color: Colors.white,
                labelText: 'POSITION',
                backgroundColor: bgColor,
                onTap: () {
                  _choosePosition();
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: defaultPadding * 2),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: TextButton(
            child: Text('SUBMIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            onPressed: () {
              if(isUpdate) {
                //upadate worker
                //_showDialog('update');
                print("update");
              } else {
                //add worker
                //_showDialog('add');
                print("add");
              }
            },
          ),
        )
      ]),
    );
  }

  _alertDialog(String func) {
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          content: Text('Are you sure $func this item'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context, 
                  builder: (_) {
                    return AlertDialog(
                      content: FutureBuilder(
                        future: _modifiAds(func),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            return Text('Success');
                          }
                          return CircularProgressIndicator();
                        }),
                    );
                  }
                );
              }, 
              child: Text('Yes')
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text('No')
            ),
          ],
        );
      });
  }

  _modifiAds(String func) {
    var id = (widget.data != null) ? widget.data["_id"] : "";
    Map<String, dynamic> data = {
      "from" : txtFrom.text,
      "video" : txtVideo.text,
      "position" : txtPosition.text,
      "status" : txtStatus.text,
    };

    var result;
    switch (func) {
      case "add":
        print("added");
        break;
      case "update":
      print("updated");
        break;
      default:
    }
    print(result);
    return result;
  }

  _choosePosition() {
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.all(defaultPadding / 2),
            child: Column(
              children: [
                TextEditFormFill(
                  controller: txtLeft,
                  labelText: "LEFT",
                  color: Colors.white,
                  backgroundColor: bgColor,
                ),
                SizedBox(height: defaultPadding),
                TextEditFormFill(
                  controller: txtRight,
                  labelText: "RIGHT",
                  color: Colors.white,
                  backgroundColor: bgColor,
                ),
                SizedBox(height: defaultPadding),
                TextEditFormFill(
                  controller: txtTop,
                  labelText: "TOP",
                  color: Colors.white,
                  backgroundColor: bgColor,
                ),
                SizedBox(height: defaultPadding),
                TextEditFormFill(
                  controller: txtBottom,
                  labelText: "BOTTOM",
                  color: Colors.white,
                  backgroundColor: bgColor,
                ),
                SizedBox(height: defaultPadding),
                TextEditFormFill(
                  controller: txtAlign,
                  labelText: "ALIGN",
                  color: Colors.white,
                  backgroundColor: bgColor,
                ),
                SizedBox(height: defaultPadding),
                TextEditFormFill(
                  controller: txtPosition,
                  labelText: "POSITION",
                  color: Colors.white,
                  backgroundColor: bgColor,
                ),
                SizedBox(height: defaultPadding),
                Center(
                  child: buttonDefault(
                    label: "OK",
                    width: 100,
                    height: 50,
                    onTap: () {
                      Navigator.pop(context, true);
                    }
                  )
                )
              ],
            )
          )
        );
      });
  }
}
