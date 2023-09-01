// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SkyMaskResponse {
  final String mask;

  const SkyMaskResponse({
    required this.mask,
  });

  SkyMaskResponse copyWith({
    String? mask,
  }) {
    return SkyMaskResponse(
      mask: mask ?? this.mask,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mask': mask,
    };
  }

  factory SkyMaskResponse.fromMap(Map<String, dynamic> map) {
    return SkyMaskResponse(
      mask: map['mask'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SkyMaskResponse.fromJson(String source) => SkyMaskResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SkyMaskResponse(mask: $mask)';

  @override
  bool operator ==(covariant SkyMaskResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.mask == mask;
  }

  @override
  int get hashCode => mask.hashCode;
}
