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
  String ipAddress = "";
  String rent = "";
  String username = "";
  String password = "";

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
              child: textEditFormFill(context,
                  color: Colors.white,
                  labelText: 'IP ADDRESS',
                  backgroundColor: bgColor,
                  initValue: widget.data!=null? widget.data['ip']: '',
                  onChange: (value) {
                    setState(() {
                      ipAddress = value;
                    });
                  },
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 2,
              child: textEditFormFill(
                context,
                color: Colors.white,
                labelText: 'RENT',
                backgroundColor: bgColor,
                onChange: (value) {
                  setState(() {
                    rent = value;
                  });
                },
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
                color: Colors.white,
                labelText: 'USER NAME',
                backgroundColor: bgColor,
                onChange: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PASSWORD',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Text(
                            obscureText ? 'SHOW' : 'HIDE',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius)),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: obscureText,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: defaultPadding),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'SUBMIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
