import 'dart:convert';
import 'dart:typed_data';
import 'package:cashu/src/utils/hex.dart';
import 'package:pointycastle/export.dart';

final secp256k1 = ECDomainParameters('secp256k1');

ECPoint hashToCurve(Uint8List secret) {
  ECPoint? point;
  while (point == null) {
    final hash = _sha256(secret);
    final hashHex = hexEncode(hash);
    final pointX = '02$hashHex';
    try {
      point = _pointFromHex(pointX);
    } catch (e) {
      secret = _sha256(secret);
    }
  }
  return point;
}

ECPoint hashHexToCurve(String secret) {
  return hashToCurve(hexDecode(secret));
}

String hashToCurveHex(Uint8List secret) {
  final point = hashToCurve(secret);
  return hexEncode(point.getEncoded());
}

String hashHexToCurveHex(String secret) {
  return hashToCurveHex(hexDecode(secret));
}

ECPoint? getBlindingPoint(String secret, {String? blindingFactor}) {
  final y = hashToCurve(utf8.encode(secret));

  if (blindingFactor == null) {
    return y;
  }

  final rG = secp256k1.G * BigInt.parse("0x$blindingFactor");

  final blinding = y + rG;

  return blinding;
}

String getBlindingHex(String secret, {String? blindingFactor}) {
  final blinding = getBlindingPoint(secret, blindingFactor: blindingFactor);
  return hexEncode(blinding!.getEncoded());
}

// Utils

ECPoint _pointFromHex(String hex) {
  return secp256k1.curve.decodePoint(hexDecode(hex))!;
}

Uint8List _sha256(Uint8List data) {
  final digest = SHA256Digest();
  return Uint8List.fromList(digest.process(data));
}
