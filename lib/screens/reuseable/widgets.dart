import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

Widget textEditFormFill(BuildContext context,
    {TextEditingController controller,
      double height,
      double width,
      String hintText,
      String labelText,
      String helperText,
      IconData suffixIcon,
      Color color,
      Color backgroundColor,
      Function onTap,
      bool readOnly = false}) {
  return Container(
    height: height ?? 48,
    width: width ?? MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[300],
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.0))),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        controller: controller,
        cursorColor: Colors.black,
        style: TextStyle(fontSize: 14.0),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
          labelText: labelText ?? '',
          labelStyle: TextStyle(
            color: color ?? primaryColor,
          ),
          helperText: helperText,
          focusedBorder: onTap == null
              ? UnderlineInputBorder(
            borderSide: BorderSide(color: color ?? primaryColor),
          )
              : InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: Icon(suffixIcon),
        ),
      ),
    ),
  );
}