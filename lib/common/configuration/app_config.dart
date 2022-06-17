part of '../configuration.dart';

class AppConfig {
  final String name;
  final String version;
  final String primaryColor;
  final String secondaryColor;
  final String logo;
  final List<String> imageProtocol;
  final String homeBanner;
  final List<String> homeRemoveObjects;

  AppConfig({
    required this.name,
    required this.version,
    required this.primaryColor,
    required this.secondaryColor,
    required this.logo,
    required this.imageProtocol,
    required this.homeBanner,
    required this.homeRemoveObjects,
  });

  AppConfig copyWith({
    String? name,
    String? version,
    String? primaryColor,
    String? secondaryColor,
    String? logo,
    List<String>? imageProtocol,
    String? homeBanner,
    List<String>? homeRemoveObjects,
  }) {
    return AppConfig(
      name: name ?? this.name,
      version: version ?? this.version,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      logo: logo ?? this.logo,
      imageProtocol: imageProtocol ?? this.imageProtocol,
      homeBanner: homeBanner ?? this.homeBanner,
      homeRemoveObjects: homeRemoveObjects ?? this.homeRemoveObjects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'version': version,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'logo': logo,
      'imageProtocol': imageProtocol,
      'homeBanner': homeBanner,
      'homeRemoveObjects': homeRemoveObjects,
    };
  }

  factory AppConfig.fromMap(Map<String, dynamic> map) {
    return AppConfig(
      name: map['name'] ?? '',
      version: map['version'] ?? '',
      primaryColor: map['primaryColor'] ?? '',
      secondaryColor: map['secondaryColor'] ?? '',
      logo: map['logo'] ?? '',
      imageProtocol: List<String>.from(map['imageProtocol']),
      homeBanner: map['homeBanner'] ?? '',
      homeRemoveObjects: List<String>.from(map['homeRemoveObjects']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppConfig.fromJson(String source) => AppConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppConfig(name: $name, version: $version, primaryColor: $primaryColor, secondaryColor: $secondaryColor, logo: $logo, imageProtocol: $imageProtocol, homeBanner: $homeBanner, homeRemoveObjects: $homeRemoveObjects)';
  }
}
