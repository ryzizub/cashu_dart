import 'dart:convert';

String base64UrlToBase64(String base64Url) {
  return base64Url.replaceAll('_', '/').replaceAll('-', '+');
}

String base64ToBase64Url(String base64) {
  return base64.replaceAll('+', '-').replaceAll('/', '_');
}

Map<String, dynamic> base64toJson(String base64) {
  // Directly decode the Base64 string, which may include padding characters
  return jsonDecode(utf8.decode(base64Decode(base64))) as Map<String, dynamic>;
}

String jsonToBase64(Map<String, dynamic> json) {
  // Encode the JSON to a UTF-8 byte array, then to a standard Base64 string
  return base64Encode(utf8.encode(jsonEncode(json)));
}
