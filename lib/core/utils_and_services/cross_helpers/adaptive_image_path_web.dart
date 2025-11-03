import 'dart:convert' show base64;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/widgets.dart';
import 'adaptive_image_path_stub.dart';

class AdaptiveImagePath extends StatelessWidget {
  final String path;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? error;

  const AdaptiveImagePath({
    super.key,
    required this.path,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.error,
  });

  bool _isHttpLike(String p) => p.startsWith('http://') || p.startsWith('https://');
  bool _isBlob(String p) => p.startsWith('blob:');
  bool _isDataUri(String p) => p.startsWith('data:');
  bool _isAsset(String p) => p.startsWith('assets/');
  bool _looksLikeOsPath(String p) =>
      p.startsWith('/storage/') ||
          p.startsWith('/sdcard/') ||
          p.startsWith('/Users/') ||
          p.contains(':\\');

  bool _isRelativeWebPath(String p) {
    if (_isHttpLike(p) || _isBlob(p) || _isDataUri(p) || _isAsset(p)) return false;
    if (_looksLikeOsPath(p)) return false;
    final lower = p.toLowerCase();
    return lower.startsWith('/') ||
        lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.svg');
  }

  Uint8List? _decodeDataUri(String dataUri) {
    try {
      final comma = dataUri.indexOf(',');
      if (comma <= 0) return null;
      final meta = dataUri.substring(0, comma);
      final payload = dataUri.substring(comma + 1);
      if (!meta.toLowerCase().contains(';base64')) return null;
      return base64.decode(payload);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return placeholder ?? const SizedBox.shrink();

    // 1) data: URI
    if (_isDataUri(path)) {
      final bytes = _decodeDataUri(path);
      if (bytes != null) {
        return Image.memory(bytes,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink());
      }
      return error ?? placeholder ?? const SizedBox.shrink();
    }

    // 2) asset
    if (_isAsset(path)) {
      return Image.asset(path,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink());
    }

    // 3) network/blob/relative URL
    if (_isBlob(path) || _isHttpLike(path) || _isRelativeWebPath(path)) {
      final origin = html.window.location.origin;
      final url = _isHttpLike(path) || _isBlob(path)
          ? path
          : origin + (path.startsWith('/') ? path : '/$path');
      return Image.network(url,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink());
    }

    // 4) OS paths not allowed on web
    if (_looksLikeOsPath(path)) {
      return placeholder ?? const SizedBox.shrink();
    }

    // 5) fallback
    return Image.network(path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink());
  }
}
