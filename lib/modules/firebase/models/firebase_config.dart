import 'dart:convert';

class FirebaseConfig {
  final bool enableFirebase;
  final bool enableCrashAnalytics;
  final bool enableRemoteConfigFirebase;

  FirebaseConfig({
    required this.enableFirebase,
    required this.enableCrashAnalytics,
    required this.enableRemoteConfigFirebase,
  });

  FirebaseConfig copyWith({
    bool? enableFirebase,
    bool? enableCrashAnalytics,
    bool? enableRemoteConfigFirebase,
  }) {
    return FirebaseConfig(
      enableFirebase: enableFirebase ?? this.enableFirebase,
      enableCrashAnalytics: enableCrashAnalytics ?? this.enableCrashAnalytics,
      enableRemoteConfigFirebase: enableRemoteConfigFirebase ?? this.enableRemoteConfigFirebase,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enableFirebase': enableFirebase,
      'enableCrashAnalytics': enableCrashAnalytics,
      'enableRemoteConfigFirebase': enableRemoteConfigFirebase,
    };
  }

  factory FirebaseConfig.fromMap(Map<String, dynamic> map) {
    return FirebaseConfig(
      enableFirebase: map['enableFirebase'] ?? false,
      enableCrashAnalytics: map['enableCrashAnalytics'] ?? false,
      enableRemoteConfigFirebase: map['enableRemoteConfigFirebase'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseConfig.fromJson(String source) => FirebaseConfig.fromMap(json.decode(source));

  @override
  String toString() => 'FirebaseConfig(enableFirebase: $enableFirebase, enableCrashAnalytics: $enableCrashAnalytics, enableRemoteConfigFirebase: $enableRemoteConfigFirebase)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FirebaseConfig &&
      other.enableFirebase == enableFirebase &&
      other.enableCrashAnalytics == enableCrashAnalytics &&
      other.enableRemoteConfigFirebase == enableRemoteConfigFirebase;
  }

  @override
  int get hashCode => enableFirebase.hashCode ^ enableCrashAnalytics.hashCode ^ enableRemoteConfigFirebase.hashCode;
}
