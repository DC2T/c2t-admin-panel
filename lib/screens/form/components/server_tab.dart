import 'package:flutter/material.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:admin/constants.dart';

class ServerFormTab extends StatefulWidget {
  var data;

  ServerFormTab({this.data});

  @override
  _ServerFormTabState createState() => _ServerFormTabState();
}

class _ServerFormTabState extends State<ServerFormTab> {
  bool obscureText = true;
  TextEditingController txtIP = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassWord = TextEditingController();
  TextEditingController txtRent = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      txtIP.text = widget.data['ip'];
      txtUserName.text = widget.data['username'];
      txtPassWord.text = widget.data['password'];
      txtRent.text = widget.data['rent'];
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
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: TextButton(
              onPressed: () {},
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
            ),
          ),
        )
      ]),
    );
  }
}
