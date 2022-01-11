import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> get(url) async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } on SocketException {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
