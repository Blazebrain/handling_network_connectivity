import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> get(url) async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } on SocketException catch (e) {
      debugPrint(e.message);
      return;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return;
    }
  }
}
