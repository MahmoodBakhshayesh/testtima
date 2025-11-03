import 'package:flutter/widgets.dart';

/// Cross-platform widget to render an image from a single [path].
/// On Web, local OS file paths cannot be read by the browser; the widget will
/// show [placeholder] in that case.
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

  @override
  Widget build(BuildContext context) {
    // Stub fallback (shouldn’t be used if conditional imports work).
    return placeholder ?? const SizedBox.shrink();
  }
}
