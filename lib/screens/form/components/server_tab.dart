import 'package:flutter/material.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:admin/constants.dart';
import 'package:admin/models/Worker.dart';

class ServerFormTab extends StatefulWidget {
  var data;

  ServerFormTab({this.data});

  @override
  _ServerFormTabState createState() => _ServerFormTabState();
}

class _ServerFormTabState extends State<ServerFormTab> {
  bool obscureText = false;
  bool isUpdate = false;
  TextEditingController txtIP = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassWord = TextEditingController();
  TextEditingController txtRent = TextEditingController();
  TextEditingController txtStatus = TextEditingController();
  TextEditingController txtRam = TextEditingController();
  TextEditingController txtCpu = TextEditingController();
  TextEditingController txtDisk = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      txtIP.text = widget.data['ip'];
      txtUserName.text = widget.data['username'];
      txtPassWord.text = widget.data['password'];
      txtRent.text = widget.data['rent'];
      txtStatus.text = widget.data['status'];
      txtRam.text = widget.data['ram'];
      txtCpu.text = widget.data['cpu'];
      txtDisk.text = widget.data['disk'];

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
              child: textEditFormFill(
                context,
                controller: txtIP,
                color: Colors.white,
                labelText: 'IP ADDRESS',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 2,
              child: textEditFormFill(
                context,
                controller: txtRent,
                color: Colors.white,
                labelText: 'RENT',
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
              child: textEditFormFill(
                context,
                controller: txtUserName,
                color: Colors.white,
                labelText: 'USER NAME',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 2,
              child: textEditFormFill(context,
                  controller: txtPassWord,
                  color: Colors.white,
                  labelText: 'PASSWORD',
                  backgroundColor: bgColor,
                  maxLine: 1,
                  obscureText: obscureText,
                  suffixIcon: buttonDefault(
                    width: 30,
                    height: 30,
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    leading: obscureText
                        ? Icon(Icons.visibility, size: 14,)
                        : Icon(Icons.visibility_off, size: 14,)
                  )),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: textEditFormFill(
                context,
                controller: txtStatus,
                color: Colors.white,
                labelText: 'STATUS',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 4,
              child: textEditFormFill(
                context,
                controller: txtRam,
                color: Colors.white,
                labelText: 'RAM',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),Expanded(
              flex: 4,
              child: textEditFormFill(
                context,
                controller: txtCpu,
                color: Colors.white,
                labelText: 'CPU',
                backgroundColor: bgColor,
              ),
            ),
            SizedBox(width: defaultPadding),Expanded(
              flex: 4,
              child: textEditFormFill(
                context,
                controller: txtDisk,
                color: Colors.white,
                labelText: 'DISK',
                backgroundColor: bgColor,
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
                _showDialog('update');
              } else {
                //add worker
                _showDialog('add');
              }
            },
          ),
        )
      ]),
    );
  }

  _showDialog(String func) {
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
                        future: _modifiWorker(func),
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

  _modifiWorker(String func) {
    var id = (widget.data != null) ? widget.data["_id"] : "";
    Map<String, dynamic> data = {
      "ip" : txtIP.text,
      "username" : txtUserName.text,
      "password" : txtPassWord.text,
      "rent" : txtRent.text,
      "status" : txtStatus.text,
      "ram" : txtRam.text,
      "cpu" : txtCpu.text,
      "disk" : txtDisk.text,
    };

    var result;
    if(func == 'add') {
      print('add');
      result = Worker.create(data);
    } else if(func == 'update') {
      print('update');
      result = Worker.update(id, data);
    }
    print(result);
    return result;
  }
}
