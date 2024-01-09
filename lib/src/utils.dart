import 'dart:typed_data';
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
      print(e);
    }
  }
  return point;
}

ECPoint pointFromHex(String hex) {
  return secp256k1.curve.decodePoint(hexToBytes(hex))!;
}

Uint8List sha256(Uint8List data) {
  final digest = SHA256Digest();
  return Uint8List.fromList(digest.process(data));
}

String bytesToHex(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

Uint8List hexToBytes(String hex) {
  final result = Uint8List(hex.length ~/ 2);
  for (var i = 0; i < hex.length; i += 2) {
    final number = int.parse(hex.substring(i, i + 2), radix: 16);
    result[i ~/ 2] = number;
  }
  return result;
}
