import 'package:handling_network_connectivity/models/power_stats_model.dart';

import 'biography_model.dart';
import 'image_model.dart';

class SuperheroResponseModel {
  String? response;
  String? id;
  String? name;
  Powerstats? powerstats;
  Biography? biography;
  Image? image;

  SuperheroResponseModel(
      {this.response,
      this.id,
      this.name,
      this.powerstats,
      this.biography,
      this.image});

  SuperheroResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    id = json['id'];
    name = json['name'];
    powerstats = json['powerstats'] != null
        ? Powerstats.fromJson(json['powerstats'])
        : null;
    biography = json['biography'] != null
        ? Biography.fromJson(json['biography'])
        : null;

    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['response'] = response;
    data['id'] = id;
    data['name'] = name;
    if (powerstats != null) {
      data['powerstats'] = powerstats!.toJson();
    }
    if (biography != null) {
      data['biography'] = biography!.toJson();
    }

    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}
