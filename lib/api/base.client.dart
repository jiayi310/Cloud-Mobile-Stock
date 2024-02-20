import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = "http://192.168.0.199:5210/api";

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 0;
    }
  }

  Future<dynamic> post(String api, dynamic obj) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(baseUrl + api));

    request.body = json.encode(obj);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}
