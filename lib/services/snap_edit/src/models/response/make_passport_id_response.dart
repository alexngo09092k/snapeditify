// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MakePassportIDResponse {
  final String output;

  const MakePassportIDResponse({
    required this.output,
  });

  MakePassportIDResponse copyWith({
    String? output,
  }) {
    return MakePassportIDResponse(
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'output': output,
    };
  }

  factory MakePassportIDResponse.fromMap(Map<String, dynamic> map) {
    return MakePassportIDResponse(
      output: map['output'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MakePassportIDResponse.fromJson(String source) => MakePassportIDResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MakePassportIDResponse(output: $output)';

  @override
  bool operator ==(covariant MakePassportIDResponse other) {
    if (identical(this, other)) return true;

    return other.output == output;
  }

  @override
  int get hashCode => output.hashCode;
}
