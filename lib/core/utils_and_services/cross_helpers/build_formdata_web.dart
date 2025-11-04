// lib/upload/build_formdata_web.dart
import 'dart:async';
import 'dart:convert' show jsonEncode, base64, utf8;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:mime/mime.dart' as mime; // add to pubspec: mime: ^1.0.5

bool _isHttp(String p) => p.startsWith('http://') || p.startsWith('https://');
bool _isBlob(String p) => p.startsWith('blob:');
bool _isData(String p) => p.startsWith('data:');
bool _looksLikeOsPath(String p) =>
    p.startsWith('/storage/') ||
        p.startsWith('/sdcard/') ||
        p.startsWith('/Users/') ||
        p.contains(':\\'); // Windows drive (e.g. C:\)

String _basename(String p) {
  final noHash = p.split('#').first;
  final q = noHash.split('?').first;
  final idx = q.lastIndexOf('/');
  return idx == -1 ? q : q.substring(idx + 1);
}

String _extForMime(String ct) {
  final lower = ct.toLowerCase();
  if (lower.startsWith('image/png')) return '.png';
  if (lower.startsWith('image/jpeg')) return '.jpg';
  if (lower.startsWith('image/webp')) return '.webp';
  if (lower.startsWith('image/gif')) return '.gif';
  if (lower.startsWith('image/svg')) return '.svg';
  if (lower.startsWith('audio/mpeg')) return '.mp3';
  if (lower.startsWith('audio/wav')) return '.wav';
  if (lower.startsWith('audio/x-wav')) return '.wav';
  if (lower.startsWith('audio/aac')) return '.aac';
  if (lower.startsWith('audio/ogg')) return '.ogg';
  if (lower.startsWith('application/pdf')) return '.pdf';
  return '';
}

String _ensureExtension(String name, String? contentType) {
  if (name.contains('.')) return name; // assume ok
  if (contentType == null) return name;
  final ext = _extForMime(contentType);
  return ext.isEmpty ? name : '$name$ext';
}

String _resolveRelativeUrl(String p) {
  if (_isHttp(p)) return p;
  if (p.startsWith('/')) return '${html.window.location.origin}$p';
  final base = Uri.parse(html.window.location.href);
  return base.resolve(p).toString();
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
      c.complete(Uint8List.fromList(utf8.encode(result)));
    } else {
      c.completeError(StateError('Unexpected FileReader result: ${result.runtimeType}'));
    }
  });
  reader.onError.listen((e) => c.completeError(e));
  reader.readAsArrayBuffer(blob);
  return c.future;
}

class _WebPart {
  final Uint8List bytes;
  final String filename;
  final MediaType? contentType;
  _WebPart(this.bytes, this.filename, this.contentType);
}

Uint8List _decodeDataUriToBytes(String dataUri) {
  final comma = dataUri.indexOf(',');
  if (comma <= 0) throw StateError('Invalid data URI');
  final meta = dataUri.substring(0, comma).toLowerCase();
  final payload = dataUri.substring(comma + 1);
  final isBase64 = meta.contains(';base64');
  return isBase64
      ? base64.decode(payload)
      : Uint8List.fromList(utf8.encode(Uri.decodeComponent(payload)));
}

String? _contentTypeFromDataUri(String dataUri) {
  final semi = dataUri.indexOf(';');
  final comma = dataUri.indexOf(',');
  if (comma <= 0) return null;
  final header = dataUri.substring(5, (semi > 0 ? semi : comma)); // after 'data:'
  return header.isEmpty ? null : header; // e.g. image/png
}

Future<_WebPart> _fromDataUri(String path) async {
  final ct = _contentTypeFromDataUri(path);
  final bytes = _decodeDataUriToBytes(path);
  final inferredName = 'file${_extForMime(ct ?? '')}';
  final filename = _ensureExtension(inferredName, ct);
  final media = ct != null ? MediaType.parse(ct) : _guessMediaType(bytes);
  return _WebPart(bytes, filename, media);
}

Future<_WebPart> _fromBlobUrl(String path) async {
  final req = await html.HttpRequest.request(path, responseType: 'blob');
  final blob = req.response as html.Blob?;
  if (blob == null) throw StateError('Failed to read blob from $path');
  final bytes = await _blobToBytes(blob);
  final ct = blob.type.isNotEmpty ? blob.type : null; // e.g. image/png
  final base = _basename(path);
  final filename = _ensureExtension(base.isEmpty ? 'blob' : base, ct);
  final media = ct != null ? MediaType.parse(ct) : _guessMediaType(bytes);
  return _WebPart(bytes, filename, media);
}

Future<_WebPart> _fromHttpOrRelative(String path) async {
  final url = _resolveRelativeUrl(path);
  final dio = Dio();
  final res = await dio.get<List<int>>(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  final bytes = Uint8List.fromList(res.data ?? const <int>[]);
  // Prefer header mimetype if provided
  final ctHeader = res.headers.value('content-type'); // e.g. image/png; charset=binary
  final ct = ctHeader?.split(';').first;
  final base = _basename(url);
  final filename = _ensureExtension(base.isEmpty ? 'file' : base, ct);
  final media = ct != null ? MediaType.parse(ct) : _guessMediaType(bytes);
  return _WebPart(bytes, filename, media);
}

MediaType? _guessMediaType(Uint8List bytes) {
  // use package:mime to guess type from magic header
  final guessed = mime.lookupMimeType('', headerBytes: bytes);
  return guessed != null ? MediaType.parse(guessed) : null;
}

Future<MultipartFile> _multipartFromPath(String path) async {
  if (_isData(path)) {
    final p = await _fromDataUri(path);
    return MultipartFile.fromBytes(p.bytes, filename: p.filename, contentType: p.contentType);
  }
  if (_isBlob(path)) {
    final p = await _fromBlobUrl(path);
    return MultipartFile.fromBytes(p.bytes, filename: p.filename, contentType: p.contentType);
  }
  if (_isHttp(path) || !_looksLikeOsPath(path)) {
    final p = await _fromHttpOrRelative(path);
    return MultipartFile.fromBytes(p.bytes, filename: p.filename, contentType: p.contentType);
  }
  throw UnsupportedError(
    'Local OS file paths are not readable on Web: "$path". '
        'Use a blob/data/http URL or pick the file and upload its bytes.',
  );
}

Future<FormData> buildFormDataFromPaths({
  required List<String> images,
  required List<String> voices,
  required Map<String, dynamic> data,
  String attachFieldName = 'attachFiles', // change if your server expects another name
}) async {
  final imgFiles = await Future.wait(images.map(_multipartFromPath));
  final vocFiles = await Future.wait(voices.map(_multipartFromPath));
  final attachings = [...imgFiles, ...vocFiles];

  return FormData.fromMap({
    attachFieldName: attachings,
    'data': jsonEncode(data),
  });
}
