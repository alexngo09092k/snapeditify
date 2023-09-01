// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RemoveBackgroundResponse {
  final String output;

  const RemoveBackgroundResponse({
    required this.output,
  });

  RemoveBackgroundResponse copyWith({
    String? output,
  }) {
    return RemoveBackgroundResponse(
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'output': output,
    };
  }

  factory RemoveBackgroundResponse.fromMap(Map<String, dynamic> map) {
    return RemoveBackgroundResponse(
      output: map['output'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveBackgroundResponse.fromJson(String source) => RemoveBackgroundResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RemoveBackgroundResponse(output: $output)';

  @override
  bool operator ==(covariant RemoveBackgroundResponse other) {
    if (identical(this, other)) return true;

    return other.output == output;
  }

  @override
  int get hashCode => output.hashCode;
}
