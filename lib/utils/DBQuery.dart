import 'dart:convert';
import 'dart:io';

import 'package:admin/configs/api.dart';
import 'package:http/http.dart' as http;

class DBQuery{
  String uri;
  String table;
  DBQuery(this.uri) {
    this.table = this.uri;
    this.uri = AppConfig.server + this.uri;
  }

  String getQueryString(Map params) {
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }

  Future findOne(id) async {
    var url = Uri.parse('${this.uri}/view?_id=${id.toString()}');

    print(url);
    var response = await http.get(url, headers: AppConfig.headers);

    if (response.statusCode == 200)
      return json.decode(response.body);

    print('Request failed with status: ${response.statusCode}.');
  }

  Future find(params) async {
    var url = Uri.parse('${this.uri}/view?${getQueryString(params)}');

    print(url);
    var response = await http.get(url, headers: AppConfig.headers);

    if (response.statusCode == 200)
      return json.decode(response.body);

    print('Request failed with status: ${response.statusCode}.');
  }

  Future post(Map<String, dynamic> data) async {
    var url = Uri.parse('${this.uri}/modifier');

    Map<String, dynamic> post_data = {};
    data.forEach((key, value) {
      post_data[key] = value.toString();
    });
    print(post_data);
    var response = await http.post(url, body: post_data);

    print(url);
    // print(response.body.toString());

    if (response.statusCode == 200 || response.statusCode == 201)
      return json.decode(response.body);

    List errors =  json.decode(response.body);

    print('Request failed with status: ${response.statusCode}.');
    return {'errors': errors};
  }

  Future update(id, Map<String, dynamic> data) async {
    var url = Uri.parse('${this.uri}/modifier/${id.toString()}');

    Map<String, dynamic> update_data = {};
    data.forEach((key, value) {
      update_data[key] = value.toString();
    });
    print(update_data);
    var response = await http.post(url, body: update_data);

    print(url);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201)
      return json.decode(response.body);

    List errors =  json.decode(response.body);

    print('Request failed with status: ${response.statusCode}.');
    return {'errors': errors};
  }

  Future delete(id) async {
    var url = Uri.parse('${this.uri}/delete/${id.toString()}');
    var response = await http.delete(url);

    if (response.statusCode == 200)
      return json.decode(response.body);

    print('Request failed with status: ${response.statusCode}.');
  }

  Future<String> uploadFile(File image) async {
    var request = http.MultipartRequest('POST', Uri.parse(this.uri + '/upload'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    var response = await request.send();
    var re = json.decode(await response.stream.bytesToString());
    if (re['success'] == 1)
      return re['file'];

    return '';
  }

}