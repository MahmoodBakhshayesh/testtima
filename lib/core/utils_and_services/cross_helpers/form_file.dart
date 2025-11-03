// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';
// import 'dart:io' as io;
//
// /// images / voices can contain either:
// ///  - file paths (native)
// ///  - or data map { 'bytes': Uint8List, 'name': String } for web
// Future<FormData> buildFormDataUniversal({
//   required List<dynamic> images,
//   required List<dynamic> voices,
//   required Map<String, dynamic> data,
// }) async {
//   Future<MultipartFile> makeFile(dynamic item) async {
//     if (kIsWeb) {
//       // Expect a structure like { 'bytes': Uint8List, 'name': 'file.png' }
//       if (item is Map && item['bytes'] is Uint8List) {
//         return MultipartFile.fromBytes(
//           item['bytes'] as Uint8List,
//           filename: item['name'] ?? 'file.bin',
//         );
//       }
//       throw Exception('On Web, each file must provide {bytes, name}');
//     } else {
//       // Native: treat as file path
//       final path = item.toString();
//       return await MultipartFile.fromFile(
//         path,
//         filename: path.split('/').last,
//       );
//     }
//   }
//
//   // Create all files in parallel
//   final imageFiles = await Future.wait(images.map(makeFile));
//   final voiceFiles = await Future.wait(voices.map(makeFile));
//
//   final attachings = [...imageFiles, ...voiceFiles];
//
//   return FormData.fromMap({
//     "attachFiles": attachings,
//     "data": jsonEncode(data),
//   });
// }
