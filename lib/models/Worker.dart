import 'package:flutter/material.dart';
import 'package:admin/utils/DBQuery.dart';

class Worker {
  static final api_uri = 'worker';
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

  static Map<String, dynamic> columns() {
    return {
      "_id": {
        "type": "String",
        "name": "_id",
        "label": "ID",
      },
      "ip": {
        "type": "String",
        "name": "ip",
        "label": "IP Address",
      },
      "username": {
        "type": "String",
        "name": "username",
        "label": "User Name",
      },
      "password": {
        "type": "String",
        "name": "password",
        "label": "Password",
      },
      "createAt": {
        "type": "Number",
        "name": "createAt",
        "label": "Create At",
      },
      "updateAt": {
        "type": "Number",
        "name": "updateAt",
        "label": "Update At",
      }
    };
  }

  static List table_columns(){
    return ['_id', 'ip', 'username', 'password', 'createAt', 'updateAt'];
  }
}