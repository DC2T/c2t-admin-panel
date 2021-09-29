import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:admin/utils/DBQuery.dart';

class Cast {
  static final api_uri = 'ads';
  static Map filter_params = {'per_page': 20, 'page': 1, };

  static Future<Map<String, dynamic>> fineOne(id) async {
    DBQuery dbQuery = new DBQuery(api_uri);
    return await dbQuery.findOne(id);
  }

  static Future find() async {
    DBQuery dbQuery = new DBQuery(api_uri);
    return await dbQuery.find(filter_params);
  }

  static Future<Map<String, dynamic>> update(id, data) async {
    DBQuery dbQuery = new DBQuery(api_uri);
    return await dbQuery.update(id, data);
  }

  static Future<Map<String, dynamic>> create(data) async {
    DBQuery dbQuery = new DBQuery(api_uri);
    return await dbQuery.post(data);
  }

  static Future delete(id) async {
    DBQuery dbQuery = new DBQuery(api_uri);
    return await dbQuery.delete(id);
  }
}