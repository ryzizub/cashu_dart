import 'dart:typed_data';
import 'package:cashu_dart/src/utils/hex.dart';
import 'package:cashu_dart/src/utils/sha256.dart';
import 'package:pointycastle/export.dart';

final secp256k1 = ECDomainParameters('secp256k1');

ECPoint hashToCurve(Uint8List secret) {
  ECPoint? point;
  while (point == null) {
    final hash = sha256(secret);
    final hashHex = bytesToHex(hash);
    final pointX = '02$hashHex';
    try {
      point = pointFromHex(pointX);
    } catch (e) {
      secret = sha256(secret);
    }
  }
  return point;
}

ECPoint pointFromHex(String hex) {
  return secp256k1.curve.decodePoint(hexToBytes(hex))!;
}
