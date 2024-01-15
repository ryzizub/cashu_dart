import 'dart:convert';
import 'dart:typed_data';

String encodeUint8toBase64(Uint8List uint8list) {
  return base64Url.encode(uint8list);
}

Uint8List encodeBase64toUint8(String base64String) {
  return base64Url.decode(base64String);
}

String encodeJsonToBase64(dynamic jsonObj) {
  String jsonString = json.encode(jsonObj);
  return encodeUint8toBase64(utf8.encode(jsonString));
}

T encodeBase64ToJson<T>(String base64String) {
  String jsonString = utf8.decode(encodeBase64toUint8(base64String));
  return json.decode(jsonString) as T;
}
