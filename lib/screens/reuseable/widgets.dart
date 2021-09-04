import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

Widget textEditFormFill(BuildContext context,
    {TextEditingController controller,
      double height,
      double width,
      String hintText,
      IconData suffixIcon,
      Function onTap,
      bool readOnly = false,
      expands = false
    }) {
  return Container(
    height: height ?? 48,
    width: width ?? MediaQuery.of(context).size.width,
    child: TextField(
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: 16.0),
      minLines: expands?null:1,
      maxLines: expands?null:1,
      expands: expands,
      decoration: InputDecoration(
        hintText: hintText??'',
        fillColor: secondaryColor,
        filled: true,
        suffixIcon: suffixIcon!=null?Icon(suffixIcon): null,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}
