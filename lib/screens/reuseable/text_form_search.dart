import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class TextEditFormFill extends StatefulWidget {
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
  bool isDropdownBox;
  bool readOnly;

  TextEditFormFill({
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
    this.isDropdownBox = false,
  });

  @override
  _TextEditFormFillState createState() => _TextEditFormFillState();
}

class _TextEditFormFillState extends State<TextEditFormFill> {
  TextEditingController controller = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(_printLatestValue);
  }

  _printLatestValue() {
    if (controller.text != '') {
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
                borderRadius: _isTyping
                    ? BorderRadius.vertical(
                        top: Radius.circular(defaultBorderRadius))
                    : BorderRadius.circular(defaultBorderRadius)),
            child: TextFormField(
              initialValue: widget.initValue,
              controller: controller,
              cursorColor: Colors.white,
              style: TextStyle(fontSize: 14.0),
              minLines: 1,
              onTap: widget.onTap??null,
              readOnly: widget.readOnly,
              maxLines: widget.maxLine,
              decoration: InputDecoration(
                  hintText: widget.hintText ?? '',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  suffixIcon: widget.suffixIcon??cleanText()),
            ),
          ),
          widget.isDropdownBox?dropdown():dropdownSearch(),
        ],
      ),
    );
  }
  cleanText(){
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _isTyping?30:0.0,
      height:_isTyping?30:0.0,
      child: InkWell(
        onTap: (){
          controller.text = '';
        },
        child: Icon(Icons.cancel),
      ),
    );
  }
  dropdownSearch() {
    return AnimatedContainer(
      height: _isTyping ? 150 : 0.0,
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
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
        ],
      ),
    );
  }
  dropdown(){
    return AnimatedContainer(
      height: _isTyping ? 150 : 0.0,
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
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
          Text(controller.text.toString()),
        ],
      ),
    );
  }
}
