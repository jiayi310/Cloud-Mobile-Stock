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
      return 0;
    }

    client.get(url);
  }

  Future<dynamic> post(String api) async {}

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}
