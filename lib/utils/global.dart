import 'package:admin/models/Category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/* 
  Not allow modifier(add, edit, delete,...) in this file utils
*/

final List<Map<String, dynamic>> tables = <Map<String, dynamic>>[
  {'name': 'Movie', 'icon': Icon(Icons.movie_creation_outlined)},
  {'name': 'Worker', 'icon': Icon(Icons.cloud_outlined)},
  {'name': 'Advertising', 'icon': Icon(Icons.campaign)},
];

String formatDate(DateTime d){
  return DateFormat('MM/dd/yyyy').format(d);
}

String formatTime(DateTime d){
  return DateFormat('HH:mm').format(d);
}

String formatDateTime(DateTime d){
  return DateFormat('MM/dd/yyyy HH:mm').format(d);
}
String filePicked = '';
pickFile() async {
  FilePickerResult result =
  await FilePicker.platform
      .pickFiles();
  if (result != null) {
    filePicked = result.files.single.path;
  } else {
    // User canceled the picker
  }
}



