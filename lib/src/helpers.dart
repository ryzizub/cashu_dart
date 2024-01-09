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
