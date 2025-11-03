import 'dart:async';
import 'dart:convert' show base64, utf8;
import 'dart:typed_data';
import 'dart:html' as html;

/// Converts a web "path" (data/blob/http/relative) into [Uint8List] bytes.
/// Throws [UnsupportedError] for local OS paths (like /storage/... or C:\...).
Future<Uint8List> webPathToBytes(String path) async {
  if (path.isEmpty) throw ArgumentError('path cannot be empty');

  // --- data: URI (base64 or text)
  if (path.startsWith('data:')) {
    final comma = path.indexOf(',');
    if (comma <= 0) throw StateError('Invalid data URI');
    final meta = path.substring(0, comma).toLowerCase();
    final payload = path.substring(comma + 1);
    final isBase64 = meta.contains(';base64');
    return isBase64
        ? base64.decode(payload)
        : Uint8List.fromList(utf8.encode(Uri.decodeComponent(payload)));
  }

  // --- blob: URL
  if (path.startsWith('blob:')) {
    final req = await html.HttpRequest.request(path, responseType: 'blob');
    final blob = req.response as html.Blob?;
    if (blob == null) throw StateError('Failed to read blob from $path');
    return _blobToBytes(blob);
  }

  // --- http/https or relative URL
  if (path.startsWith('http://') ||
      path.startsWith('https://') ||
      path.startsWith('/')) {
    final absolute = _resolveRelativeUrl(path);
    final req = await html.HttpRequest.request(
      absolute,
      responseType: 'arraybuffer',
    );
    final data = req.response;
    if (data is ByteBuffer) return Uint8List.view(data);
    if (data is Uint8List) return data;
    throw StateError('Unexpected response type: ${data.runtimeType}');
  }

  // --- Local OS-like paths are not accessible
  if (path.startsWith('/storage/') ||
      path.startsWith('/sdcard/') ||
      path.startsWith('/Users/') ||
      path.contains(':\\')) {
    throw UnsupportedError(
      'Local OS file paths are not readable on Web: "$path". '
          'Use a blob/data/http URL or pick the file and upload its bytes.',
    );
  }

  throw UnsupportedError('Unsupported path format: "$path"');
}

/// Helper to convert Blob → bytes.
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
      c.completeError(StateError('Unexpected FileReader result type: ${result.runtimeType}'));
    }
  });
  reader.onError.listen((e) => c.completeError(e));
  reader.readAsArrayBuffer(blob);

  return c.future;
}

/// Resolves relative URLs against the current browser location.
String _resolveRelativeUrl(String path) {
  if (path.startsWith('http://') || path.startsWith('https://')) return path;
  if (path.startsWith('/')) return '${html.window.location.origin}$path';
  final base = Uri.parse(html.window.location.href);
  return base.resolve(path).toString();
}
