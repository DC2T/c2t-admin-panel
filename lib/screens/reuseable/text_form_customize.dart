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
  bool readOnly;
  String helperText;
  bool obscureText;
  List<Map<String, dynamic>> data;

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
    this.helperText,
    this.obscureText = true,
    this.data = null,
  });

  @override
  _TextEditFormFillState createState() => _TextEditFormFillState();
}

class _TextEditFormFillState extends State<TextEditFormFill> with SingleTickerProviderStateMixin {
  bool _isTyping = false;
  bool _isOpenDropdown = false;

  GlobalKey _key;
  bool isDropDownOpen = false;
  Offset dropPosition;
  Size fieldSize;
  OverlayEntry _overlayEntry;
  BorderRadius _borderRadius;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    widget.controller.addListener(_textEditListener);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = BorderRadius.circular(defaultBorderRadius);
    super.initState();
  }

  _textEditListener() {
    if (widget.controller.text != '') {
      _isTyping = true;
    } else {
      _isTyping = false;
    }
    setState(() {});
  }

  _dropdownOnTap(){
      isDropDownOpen?closeDropDown():openDropDown();
  }

  void closeDropDown() {
    _overlayEntry.remove();
    _animationController.reverse();
    isDropDownOpen = !isDropDownOpen;
  }

  findButton() {
    RenderBox renderBox = context.findRenderObject();
    fieldSize = renderBox.size;
    dropPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openDropDown() {
    findButton();
    _overlayEntry = dropdown();
    Overlay.of(context).insert(_overlayEntry);
    isDropDownOpen = !isDropDownOpen;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    _animationController.dispose();
    super.dispose();
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
              onTap: widget.onTap ?? (widget.dropdownBox?_dropdownOnTap:null),
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
        ],
      ),
    );
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

  OverlayEntry dropdown() {
    return OverlayEntry(
      builder: (context){
        return Positioned(
          top: dropPosition.dy + fieldSize.height,
          left: dropPosition.dx,
          width: fieldSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                  padding: const EdgeInsets.only(top: defaultPadding),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: _borderRadius,
                  ),
                  child: Theme(
                    data: ThemeData(
                      iconTheme: IconThemeData(
                        color: primaryColor,
                      ),
                    ),
                    child: Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              widget.controller.text = widget.data[index]['name'];
                              closeDropDown();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              width: MediaQuery.of(context).size.width,
                              height: 40.0,
                              child: dropdownItem(widget.data[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  dropdownItem(data){
    return Text(data['name'].toString());
  }
}
