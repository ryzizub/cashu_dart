import 'dart:convert';
import 'dart:typed_data';

String encodeUint8toBase64(Uint8List uint8list) {
  return base64Encode(uint8list);
}

Uint8List encodeBase64toUint8(String base64String) {
  return base64Decode(base64String);
}

String encodeJsonToBase64(dynamic jsonObj) {
  String jsonString = json.encode(jsonObj);
  return base64urlFromBase64(base64Encode(utf8.encode(jsonString)));
}

Map<String, dynamic> encodeBase64ToJson(String base64String) {
  String jsonString =
      utf8.decode(base64Decode(base64urlToBase64(base64String)));
  return json.decode(jsonString);
}

String base64urlToBase64(String str) {
  return str.replaceAll('-', '+').replaceAll('_', '/');
}

String base64urlFromBase64(String str) {
  return str.replaceAll('+', '-').replaceAll('/', '_').split('=')[0];
}
