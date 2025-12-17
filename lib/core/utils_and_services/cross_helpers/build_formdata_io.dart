import 'dart:convert';
import 'dart:io' as io;
import 'package:dio/dio.dart';

String _basename(String p) {
  final idx = p.lastIndexOf(RegExp(r'[\/\\]'));
  return idx == -1 ? p : p.substring(idx + 1);
}

Future<MultipartFile> _fileFromPath(String path) async {
  return MultipartFile.fromFile(path, filename: _basename(path));
}

Future<FormData> buildFormDataFromPaths({
  required List<String> images,
  required List<String> voices,
  required Map<String, dynamic> data,
  String attachFieldName = 'attachFiles',

}) async {
  final imageFiles = await Future.wait(images.map(_fileFromPath));
  final voiceFiles = await Future.wait(voices.map(_fileFromPath));
  final attachings = [...imageFiles, ...voiceFiles];

  return FormData.fromMap({
    attachFieldName: attachings,
    "data": jsonEncode(data),
  });
}
