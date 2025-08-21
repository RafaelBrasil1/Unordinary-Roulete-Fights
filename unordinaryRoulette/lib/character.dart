// Em: lib/character.dart

class Character {
  final String name;
  final String gender;
  final String power;
  final String hairColor;
  final String eyeColor;
  final String origin;
  final double originModifier;
  final double strength;
  final double speed;
  final double trick;
  final double recovery;
  final double defense;
  final double finalLevel;

  Character({
    required this.name,
    required this.gender,
    required this.power,
    required this.hairColor,
    required this.eyeColor,
    required this.origin,
    required this.originModifier,
    required this.strength,
    required this.speed,
    required this.trick,
    required this.recovery,
    required this.defense,
    required this.finalLevel,
  });

// Os métodos toJson e fromJson foram removidos.
}