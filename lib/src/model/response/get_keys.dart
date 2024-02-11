import 'package:cashu_dart/src/model/types.dart';

class GetKeysResponse {
  GetKeysResponse({
    required this.keysets,
  });

  final List<KeySet> keysets;

  factory GetKeysResponse.fromJson(Map<String, dynamic> json) {
    return GetKeysResponse(
      keysets: List<KeySet>.from(
        json['keysets'].map((x) => KeySet.fromJson(x)),
      ),
    );
  }
}

class KeySet {
  KeySet({
    required this.id,
    required this.unit,
    required this.keys,
  });

  final String id;
  final String unit;
  final MintKeys keys;

  factory KeySet.fromJson(Map<String, dynamic> json) {
    return KeySet(
      id: json['id'] as String,
      unit: json['unit'] as String,
      keys: Map<String, String>.from(json['keys'] as Map<String, dynamic>),
    );
  }
}
