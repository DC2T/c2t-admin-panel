import 'package:flutter/material.dart';
import 'package:admin/utils/DBQuery.dart';

class Country {
  static final api_uri = 'country';
  static Map filter_params = {'per_page': 20, 'page': 1, };

  static Future<Map<String, dynamic>> findOne(id) async {
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