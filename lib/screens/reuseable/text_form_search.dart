import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class TextEditFormFill extends StatefulWidget {
  TextEditingController controller;
  String initValue;
  double height;
  double width;
  String hintText;
  String labelText;
  Widget suffixIcon;
  Function onTap;
  Color color;
  Color backgroundColor;
  int maxLine;
  bool dropdownBox;
  bool dropdownSearch;
  bool readOnly;
  String helperText;
  bool obscureText;

  TextEditFormFill({
    this.controller,
    this.initValue,
    this.height = 48,
    this.width,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.color,
    this.backgroundColor = secondaryColor,
    this.maxLine = 100,
    this.readOnly = false,
    this.onTap,
    this.dropdownBox = false,
    this.dropdownSearch = false,
    this.helperText,
    this.obscureText = true
  });

  @override
  _TextEditFormFillState createState() => _TextEditFormFillState();
}

class _TextEditFormFillState extends State<TextEditFormFill> {
  bool _isTyping = false;
  bool _isOpenDropdown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(_printLatestValue);
  }

  _printLatestValue() {
    if (widget.controller.text != '') {
      _isTyping = true;
    } else {
      _isTyping = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.labelText ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: widget.height,
            width: widget.width ?? MediaQuery.of(context).size.width,
            // width: width ?? MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: (_isTyping || _isOpenDropdown)
                    ? BorderRadius.vertical(
                        top: Radius.circular(defaultBorderRadius))
                    : BorderRadius.circular(defaultBorderRadius)),
            child: TextFormField(
              initialValue: widget.initValue,
              controller: widget.controller,
              cursorColor: Colors.white,
              style: TextStyle(fontSize: 14.0),
              obscureText: !widget.obscureText,
              onTap: widget.onTap ?? null,
              readOnly: widget.readOnly,
              minLines: 1,
              maxLines: widget.maxLine,
              decoration: InputDecoration(
                  hintText: widget.hintText ?? '',
                  helperText: widget.helperText,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  suffixIcon: widget.suffixIcon ?? cleanText()),
            ),
          ),
          dropdown(),
          dropdownSearch(),
        ],
      ),
    );
  }

  openDropdown(){
    setState(() {
      _isOpenDropdown = !_isOpenDropdown;
    });
  }

  cleanText() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _isTyping ? 30 : 0.0,
      height: _isTyping ? 30 : 0.0,
      child: _isTyping
          ? InkWell(
              onTap: () {
                widget.controller.text = '';
              },
              child: Icon(Icons.cancel),
            )
          : null,
    );
  }

  dropdownSearch() {
    return AnimatedContainer(
      height: (_isTyping && widget.dropdownSearch) ? 150 : 0.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(defaultBorderRadius)),
      ),
      duration: Duration(milliseconds: 400),
      child: ListView(
        children: [
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),

        ],
      ),
    );
  }

  dropdown() {
    return AnimatedContainer(
      height: (_isOpenDropdown && !_isTyping) ? 150 : 0.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(defaultBorderRadius)),
      ),
      duration: Duration(milliseconds: 400),
      child: ListView(
        children: [
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
          Text(widget.controller.text.toString()),
        ],
      ),
    );
  }
}
