import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handling_network_connectivity/app/app.locator.dart';
import 'package:handling_network_connectivity/services/connectivity_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _connectivityService = locator<ConnectionStatusSingleton>();
  Future<dynamic> get(url) async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } on SocketException catch (e) {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
