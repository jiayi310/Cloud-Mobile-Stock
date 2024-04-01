import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = "http://192.168.0.100:5210/api";

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> post(String api, dynamic obj) async {
    var headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(baseUrl + api),
        headers: headers,
        body: obj,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<dynamic> postPDF(String api, dynamic obj) async {
    var headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(baseUrl + api),
        headers: headers,
        body: obj,
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}
