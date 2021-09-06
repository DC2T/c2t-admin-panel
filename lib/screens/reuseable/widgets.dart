import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

Widget textEditFormFill(
  BuildContext context, {
  TextEditingController controller,
  double height,
  double width,
  String hintText,
  String labelText,
  String helperText,
  IconData suffixIcon,
  Color color,
  Color backgroundColor,
  Function onTap,
  Function onChange,
  bool readOnly = false,
  expands = false,
}) {
  return Container(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            labelText ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: height ?? 48,
          width: width ?? MediaQuery.of(context).size.width,
          // width: width ?? MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: backgroundColor ?? secondaryColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
          child: TextFormField(
            readOnly: readOnly,
            onTap: onTap,
            onChanged: (value) {
              onChange(value);
            },
            controller: controller,
            cursorColor: Colors.white,
            style: TextStyle(fontSize: 14.0),
            minLines: expands ? null : 1,
            maxLines: expands ? null : 100,
            expands: expands,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              helperText: helperText,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            ),
          ),
        ),
      ],
    ),
  );
}

class MultiSelectInput extends StatefulWidget {
  final String typeInput;
  final List<String> items;
  final Function setSelected;

  const MultiSelectInput(
      {Key key, this.typeInput, this.items, this.setSelected})
      : super(key: key);

  @override
  _MultiSelectInputState createState() => _MultiSelectInputState();
}

class _MultiSelectInputState extends State<MultiSelectInput> {
  List<String> selectedItem = [];
  List<Widget> selected = [];
  bool showItem = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              child: ListTile(
                title: selectedItem.isEmpty
                    ? Row(
                        children: selected,
                      )
                    : Text(""),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () {},
              ),
            ),
            showItem
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 48),
                    color: Colors.red,
                    child: Column(
                      children: [
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                        Text('drop box'),
                      ],
                    ))
                : Container(),
          ],
        ));
  }
}
