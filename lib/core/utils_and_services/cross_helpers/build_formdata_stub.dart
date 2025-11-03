import 'dart:convert';
import 'package:dio/dio.dart';

/// Fallback to satisfy non-web/non-io analyzers. Not used at runtime.
Future<FormData> buildFormDataFromPaths({
  String? imgKey,
  required List<String> images,
  required List<String> voices,
  required Map<String, dynamic> data,
}) async {
  return FormData.fromMap({
    "attachFiles": const <MultipartFile>[],
    "data": jsonEncode(data),
  });
}
