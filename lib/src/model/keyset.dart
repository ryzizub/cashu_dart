import 'package:cashu_dart/src/model/types.dart';

class KeySet {
  KeySet({
    required this.id,
    required this.unit,
    this.active,
    this.keys,
  });

  final String id;
  final String unit;
  MintKeys? keys;
  final bool? active;

  factory KeySet.fromJson(Map<String, dynamic> json) {
    return KeySet(
      id: json['id'] as String,
      unit: json['unit'] as String,
      keys: json['keys'] == null
          ? null
          : Map<String, String>.from(json['keys'] as Map<String, dynamic>),
      active: json['active'] as bool?,
    );
  }
}
