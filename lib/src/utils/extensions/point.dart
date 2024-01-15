import 'package:pointycastle/export.dart';
import 'package:cashu/src/utils/hex.dart';

extension ECPointX on ECPoint? {
  String? get hex => this == null ? null : hexEncode(this!.getEncoded());
}

extension StringX on String? {
  ECPoint? get point => this == null ? null : _pointFromHex(this!);
}

extension ECPointXX on ECPoint {
  String get hex => hexEncode(getEncoded());
}

extension StringXx on String {
  ECPoint get point => _pointFromHex(this);
}

ECPoint _pointFromHex(String hex) {
  return ECDomainParameters('secp256k1').curve.decodePoint(hexDecode(hex))!;
}
