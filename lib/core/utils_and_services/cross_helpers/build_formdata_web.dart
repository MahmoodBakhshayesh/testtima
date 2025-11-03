// lib/upload/build_formdata_web.dart
import 'dart:async';
import 'dart:convert' show jsonEncode, base64, utf8;
import 'dart:developer';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';

bool _isHttp(String p) => p.startsWith('http://') || p.startsWith('https://');
bool _isBlob(String p) => p.startsWith('blob:');
bool _isData(String p) => p.startsWith('data:');
bool _looksLikeOsPath(String p) =>
    p.startsWith('/storage/') ||
        p.startsWith('/sdcard/') ||
        p.startsWith('/Users/') ||
        p.contains(':\\'); // Windows drive (e.g., C:\)

String _basename(String p) {
  // strip query/hash
  final noHash = p.split('#').first;
  final q = noHash.split('?').first;
  final idx = q.lastIndexOf('/');
  return idx == -1 ? q : q.substring(idx + 1);
}

String _resolveRelativeUrl(String p) {
  if (p.startsWith('/')) {
    return '${html.window.location.origin}$p';
  }
  final base = Uri.parse(html.window.location.href);
  return base.resolve(p).toString();
}

Future<Uint8List> _fetchHttpBytes(String url) async {
  final dio = Dio();
  final res = await dio.get<List<int>>(
    url,
    options: Options(
      responseType: ResponseType.bytes,
      followRedirects: true,
      receiveDataWhenStatusError: true,
    ),
  );
  final data = res.data;
  if (data == null) {
    throw StateError('Failed to download bytes from $url');
  }
  return Uint8List.fromList(data);
}

Future<Uint8List> _blobToBytes(html.Blob blob) {
  final c = Completer<Uint8List>();
  final reader = html.FileReader();

  reader.onLoadEnd.listen((_) {
    final result = reader.result;
    if (result == null) {
      c.completeError(StateError('FileReader result was null'));
      return;
    }
    if (result is ByteBuffer) {
      c.complete(Uint8List.view(result));
    } else if (result is Uint8List) {
      c.complete(result);
    } else if (result is List<int>) {
      c.complete(Uint8List.fromList(result));
    } else if (result is String) {
      // Shouldn't happen for readAsArrayBuffer, but be defensive.
      c.complete(Uint8List.fromList(utf8.encode(result)));
    } else {
      c.completeError(
        StateError('Unexpected FileReader result: ${result.runtimeType}'),
      );
    }
  });
  reader.onError.listen((e) => c.completeError(e));

  reader.readAsArrayBuffer(blob);
  return c.future;
}

Future<Uint8List> _fetchBlobUrlBytes(String blobUrl) async {
  final req = await html.HttpRequest.request(
    blobUrl,
    responseType: 'blob',
  );
  final blob = req.response as html.Blob?;
  if (blob == null) {
    throw StateError('Failed to read blob from $blobUrl');
  }
  return _blobToBytes(blob);
}

Uint8List _decodeDataUri(String dataUri) {
  final comma = dataUri.indexOf(',');
  if (comma <= 0) throw StateError('Invalid data URI');
  final meta = dataUri.substring(0, comma).toLowerCase();
  final payload = dataUri.substring(comma + 1);

  final isBase64 = meta.contains(';base64');
  if (isBase64) {
    return base64.decode(payload);
  }
  // URL-encoded (e.g., data:text/plain,hello%20world)
  final decoded = Uri.decodeComponent(payload);
  return Uint8List.fromList(utf8.encode(decoded));
}

Future<MultipartFile> _multipartFromPath(String path) async {
  // 1) data: URI
  if (_isData(path)) {
    final bytes = _decodeDataUri(path);
    final name = 'file_${bytes.length}.bin';
    return MultipartFile.fromBytes(bytes, filename: name);
  }

  // 2) blob: URL
  if (_isBlob(path)) {
    final bytes = await _fetchBlobUrlBytes(path);
    final name = _basename(path).isEmpty ? 'blob.bin' : _basename(path);
    return MultipartFile.fromBytes(bytes, filename: name);
  }

  // 3) http/https OR relative web path (not OS-like)
  if (_isHttp(path) || (!_looksLikeOsPath(path))) {
    final absolute = _isHttp(path) ? path : _resolveRelativeUrl(path);
    final bytes = await _fetchHttpBytes(absolute);
    final name = _basename(absolute).isEmpty ? 'file.bin' : _basename(absolute);
    return MultipartFile.fromBytes(bytes, filename: name);
  }

  // 4) Local OS-style paths are not readable on Web
  throw UnsupportedError(
    'Local OS file paths are not readable on Web: "$path". '
        'Use a blob/data/http URL or pick the file and upload its bytes.',
  );
}

Future<FormData> buildFormDataFromPaths({
  String? imgKey,
  required List<String> images,
  required List<String> voices,
  required Map<String, dynamic> data,
}) async {
  final imgFiles = await Future.wait(images.map(_multipartFromPath));
  final vocFiles = await Future.wait(voices.map(_multipartFromPath));
  final attachings = [...imgFiles, ...vocFiles];

  log("build forms ${imgFiles.length}");
  return FormData.fromMap({
   "attachFiles": attachings,
    "data": jsonEncode(data),
  });
}
