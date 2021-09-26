import 'dart:async';
import 'package:admin/utils/DBQuery.dart';

class Movie {
  static final api_uri = 'movie';
  static Map filter_params = {
    'per_page': 20,
    'page': 1,
  };

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
      "photo": {
        "type": "String",
        "name": "photo",
        "label": "Photo",
      },
      "title": {
        "type": "String",
        "name": "title",
        "label": "Title",
      },
      "subTitle": {
        "type": "String",
        "name": "subTitle",
        "label": "Sub Title",
      },
      "form": {
        "type": "Boolean",
        "name": "form",
        "label": "Form",
      },
      "storyline": {
        "type": "String",
        "name": "storyline",
        "label": "Storyline",
      },
      "categories": {
        "type": "Array",
        "name": "categories",
        "label": "Categories",
      },
      "countries": {
        "type": "Array",
        "name": "countries",
        "label": "Countries",
      },
      "languages": {
        "type": "Array",
        "name": "languages",
        "label": "Languages",
      },
      "directors": {
        "type": "Array",
        "name": "directors",
        "label": "Directors",
      },
       "cast": {
        "type": "Array",
        "name": "stars",
        "label": "Stars",
      },
      "episodes": {
        "type": "Array",
        "name": "fIds",
        "label": "Episodes",
      },
      "views": {
        "type": "Number",
        "name": "views",
        "label": "Views",
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

  static List table_columns() {
    return [
      '_id',
      'photo',
      'title',
      'form',
      'views',
      'createAt',
      'updateAt'
    ];
  }
}
