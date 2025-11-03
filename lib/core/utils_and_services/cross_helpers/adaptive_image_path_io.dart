import 'dart:io';
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
  bool _isAsset(String p) => p.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return placeholder ?? const SizedBox.shrink();

    if (_isAsset(path)) {
      return Image.asset(
        path, fit: fit, width: width, height: height,
        errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink(),
      );
    }

    if (_isHttpLike(path)) {
      return Image.network(
        path, fit: fit, width: width, height: height,
        errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink(),
      );
    }

    // Treat anything else as a real filesystem path.
    return Image.file(
      File(path), fit: fit, width: width, height: height,
      errorBuilder: (_, __, ___) => error ?? const SizedBox.shrink(),
    );
  }
}
