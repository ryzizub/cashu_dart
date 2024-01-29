import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';

Uint8List sha256(Uint8List data) {
  final digest = SHA256Digest();
  return Uint8List.fromList(digest.process(data));
}
