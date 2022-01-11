class Powerstats {
  String? intelligence;
  String? strength;
  String? speed;
  String? durability;
  String? power;
  String? combat;

  Powerstats(
      {this.intelligence,
      this.strength,
      this.speed,
      this.durability,
      this.power,
      this.combat});

  Powerstats.fromJson(Map<String, dynamic> json) {
    intelligence = json['intelligence'];
    strength = json['strength'];
    speed = json['speed'];
    durability = json['durability'];
    power = json['power'];
    combat = json['combat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['intelligence'] = intelligence;
    data['strength'] = strength;
    data['speed'] = speed;
    data['durability'] = durability;
    data['power'] = power;
    data['combat'] = combat;
    return data;
  }
}
