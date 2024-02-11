import 'dart:io';

import 'package:dio/dio.dart';

Future<Map<String, dynamic>?> request(
  String url,
  String method,
  String? body,
) async {
  if (method == 'GET') {
    return await _getRequest(url);
  } else if (method == 'POST') {
    return await _postRequest(url, body);
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> _getRequest(String url) async {
  final dio = Dio();
  final response = await dio.get<Map<String, dynamic>>(url);

  if (response.statusCode == HttpStatus.ok) {
    return response.data;
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> _postRequest(String url, String? body) async {
  final dio = Dio();
  final response = await dio.post<Map<String, dynamic>>(url, data: body);

  if (response.statusCode == HttpStatus.ok) {
    return response.data;
  } else {
    return null;
  }
}
