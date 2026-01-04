import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class OcrApi {
  final Dio _dio;

  OcrApi({Dio? dio})
      : _dio = dio ??
      Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        // IMPORTANT: don't throw on 4xx/5xx so you can read response.body
        validateStatus: (code) => code != null && code >= 200 && code < 600,
      ));

  Future<Response<dynamic>> postLog({
    String url = 'https://check-ocr.multidcs.com/api/v1/log',
    File? image,         // nullable
    required Map<String, dynamic> data, // will be sent as JSON string in form-data
    Map<String, String>? headers,       // optional extra headers
  }) async {
    final form = FormData();


    // "image" part (optional)
    if (image != null) {
      form.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split(Platform.pathSeparator).last,
            // contentType: MediaType('image', 'png'), // optional (needs http_parser)
          ),
        ),
      );
    }

    // "data" part as TEXT (Postman shows Text: {"a":"dfs"})
    form.fields.add(MapEntry('data', dataToJsonString(data)));

    final response = await _dio.post(
      url,
      data: form,
      options: Options(
        headers: {
          ...?headers,
          // Dio will set the proper multipart boundary automatically.
          // Don't manually set Content-Type here unless you know what you're doing.
        },
      ),
    );

    return response;
  }

  /// Ensures it becomes exactly a JSON string like: {"a":"dfs"}
  String dataToJsonString(Map<String, dynamic> map) {
    // avoid importing dart:convert in every file—keep it simple here
    // but feel free to use jsonEncode(map)
    return const JsonEncoder().convert(map);
  }
}
