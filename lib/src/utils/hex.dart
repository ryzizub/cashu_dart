import 'dart:core';
import 'dart:typed_data';

import 'package:convert/convert.dart';

Uint8List hexDecode(String input) {
  final list = hex.decode(input);
  return Uint8List.fromList(list);
}

String hexEncode(Uint8List input) {
  return hex.encode(input);
}

BigInt hexToBigInt(String input) {
  return BigInt.parse(input, radix: 16);
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
