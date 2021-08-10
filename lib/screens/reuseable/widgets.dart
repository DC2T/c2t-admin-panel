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
      bool readOnly = false,
      expands = false
    }) {
  return Container(
    height: height ?? 48,
    width: width ?? 300,
    // width: width ?? MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
        color: backgroundColor ?? secondaryColor,
        borderRadius: BorderRadius.circular(defaultBorderRadius)),
    child: TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: 14.0),
      minLines: expands?null:1,
      maxLines: expands?null:100,
      expands: expands,
      decoration: InputDecoration(
        hintText: hintText??'',
        labelText: labelText ?? '',
        labelStyle: TextStyle(
          color: color ?? primaryColor,
        ),
        helperText: helperText,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        suffixIcon: suffixIcon!=null?Icon(suffixIcon): null,
      ),
    ),
  );
}