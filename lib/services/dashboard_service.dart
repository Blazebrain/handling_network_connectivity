import 'dart:convert';

import 'package:handling_network_connectivity/app/app.locator.dart';
import 'package:handling_network_connectivity/models/character_model.dart';
import 'package:handling_network_connectivity/services/api_service.dart';
import 'package:handling_network_connectivity/utils/api_constant.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  final _apiService = locator<ApiService>();

  Future<List<CharacterModel>?> getCharactersDetails() async {
    await Future.delayed(const Duration(seconds: 5));
    final response = await _apiService.get(ApiConstants.getCharacters);

    if (response != null) {
      final charactersList = CharacterResponseModel.fromJson(response).results;

      return charactersList;
    }
  }
}
