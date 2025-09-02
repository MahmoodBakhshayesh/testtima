import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:developer' as dev;

class Uploader {
  Uploader({
    Dio? dio,
    this.baseUrl = '',
    this.defaultHeaders = const {},
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) : _dio = dio ??
      Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: defaultHeaders,
        connectTimeout: connectTimeout ?? const Duration(minutes: 20),
        receiveTimeout: receiveTimeout ?? const Duration(minutes: 60),
        sendTimeout: sendTimeout ?? const Duration(minutes: 60),
      ));

  final Dio _dio;
  final String baseUrl;
  final Map<String, dynamic> defaultHeaders;

  /// Upload with files from disk (single or multiple).
  Future<void> uploadImagesWithLog({
    required Uri url,
    required List<File> images,
    required Map<String,dynamic> log,
    Map<String, String>? headers,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    final List<MultipartFile> files = [];
    for (final file in images) {
      // Best effort content-type guessing (jpeg/png). Adjust as needed.
      final name = file.path
          .split(Platform.pathSeparator)
          .last;
      final isPng = name.toLowerCase().endsWith('.png');
      files.add(
        await MultipartFile.fromFile(
          file.path,
          filename: name,
          contentType: MediaType('image', isPng ? 'png' : 'jpeg'),
        ),
      );
    }

    // If your backend expects multiple files under the same key:
    //   "images": [file1, file2, ...]
    // If it expects "images[]" specifically, rename the key below to "images[]".
    final formData = FormData.fromMap({
      'images': files.length == 1 ? files.first : files,
      'logs': log['logs'],
      "improving": log['improving'],
      "consensus":log['consensus'],


    });

    dev.log("loggin to ${url.toString()}");
    try {
      final res = await _dio.postUri(
        url,
        data: formData,
        options: Options(

          // Content-Type will be set to multipart/form-data with boundary by Dio automatically.
          headers: headers,
        ),
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
      if (res.statusCode == 200) {
        dev.log("upload done");
      } else {
        dev.log(res.statusMessage ?? "error log upload");
      }
    } catch (e) {
        dev.log("$e");
        if(e is DioException){
          dev.log(e.message??e.error.toString());
        }
    }
  }

    /// Variant for when you have bytes (e.g., in-memory screenshot).
    Future<Response<dynamic>> uploadImageBytesWithLog({
      required Uri url,
      required List<({Uint8List bytes, String filename, String mime})> images,
      required String log,
      Map<String, String>? headers,
      ProgressCallback? onSendProgress,
      CancelToken? cancelToken,
    }) async {
      final files = images
          .map((e) =>
          MultipartFile.fromBytes(
            e.bytes,
            filename: e.filename,
            contentType: _mimeToMediaType(e.mime),
          ))
          .toList();

      final formData = FormData.fromMap({
        'images': files.length == 1 ? files.first : files,
        'log': log,
      });

      return _dio.postUri(
        url,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
    }

    MediaType _mimeToMediaType(String mime) {
      final parts = mime.split('/');
      return MediaType(parts.first, parts.length > 1 ? parts[1] : 'octet-stream');
    }
  }
