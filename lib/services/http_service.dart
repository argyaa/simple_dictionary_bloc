import 'package:http/http.dart' as http;

class HttpService {
  static const baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  static Future<http.Response> getRequest(String query) async {
    http.Response response;
    var url = Uri.parse(baseUrl + query);

    try {
      response = await http.get(url);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }
}
