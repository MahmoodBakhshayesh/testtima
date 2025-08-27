import 'package:dio/dio.dart';

class TimaticClientOptions {
  final String baseUrl;
  final String? apiKey;
  final Map<String, String>? headers;
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;

  const TimaticClientOptions({
    required this.baseUrl,
    this.apiKey,
    this.headers,
    this.connectTimeout = const Duration(minutes: 2),
    this.sendTimeout = const Duration(minutes: 2),
    this.receiveTimeout = const Duration(minutes: 2),
  });
}

class TimaticClient {
  final Dio _dio;
  String? _token;

  TimaticClient._(this._dio);

  factory TimaticClient(TimaticClientOptions options) {
    final dio = Dio(BaseOptions(
      baseUrl: options.baseUrl,
      connectTimeout: options.connectTimeout,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      headers: {
        if (options.apiKey != null) 'X-API-Key': options.apiKey!,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        ...?options.headers,
      },
    ));

    final client = TimaticClient._(dio);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (req, handler) {
        // Inject bearer token if present
        if (client._token != null && client._token!.isNotEmpty) {
          req.headers['Authorization'] = 'Bearer ${client._token}';
        }
        handler.next(req);
      },
      onResponse: (res, handler) => handler.next(res),
      onError: (e, handler) => handler.next(e),
    ));

    return client;
  }

  Dio get dio => _dio;

  /// Set/clear auth token obtained after login
  void setAuthToken(String? token) {
    _token = token;
  }
  void setUrl(String url) {
    _dio.options.baseUrl = url;
  }

  String? get authToken => _token;
}
