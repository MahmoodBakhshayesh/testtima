import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../core/utils_and_services/downloader/downloader_util.dart';

// ✅ adjust import to your project path


typedef DownloadDone = void Function(String? savedPath);
typedef DownloadError = void Function(Object error, StackTrace st);

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    super.key,
    required this.url,
    this.label = 'Download',
    this.fileName,
    this.subDir = 'downloads',
    this.headers,

    // styling similar to MyButton
    this.height = 40,
    this.width,
    this.fontSize = 13,
    this.iconSize = 18,
    this.radius = 5,
    this.padding,
    this.style,
    this.color,
    this.textColor,
    this.borderSide,
    this.borderRadius,
    this.icon,
    this.iconInRight = false,
    this.reverse = false,
    this.fade = false,
    this.disabled = false,

    // behavior
    this.showPercent = true,
    this.onDone,
    this.onError,
  });

  final String url;

  final String label;
  final String? fileName;
  final String subDir;
  final Map<String, String>? headers;

  // style
  final double height;
  final double? width;
  final double fontSize;
  final double iconSize;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final Color? color;
  final Color? textColor;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final IconData? icon;
  final bool iconInRight;
  final bool reverse;
  final bool fade;
  final bool disabled;

  // progress UI
  final bool showPercent;

  // callbacks
  final DownloadDone? onDone;
  final DownloadError? onError;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton>
    with SingleTickerProviderStateMixin {
  bool _downloading = false;

  int _received = 0;
  int _total = 0;

  late final AnimationController _pulse =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);

  double get _progress {
    if (_total <= 0) return 0;
    return (_received / _total).clamp(0.0, 1.0);
  }

  String _percentText() {
    final p = (_progress * 100).round();
    return '$p%';
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _startDownload() async {
    if (widget.disabled) return;
    if (_downloading) return;

    setState(() {
      _downloading = true;
      _received = 0;
      _total = 0;
    });

    try {
      final path = await DownloaderUtil.downloadSaveAndOpen(
        widget.url,
        fileName: widget.fileName,
        subDir: widget.subDir,
        headers: widget.headers,
        onProgress: (r, t) {
          if (!mounted) return;
          setState(() {
            _received = r;
            _total = t;
          });
        },
      );

      widget.onDone?.call(path);
    } catch (e, st) {
      widget.onError?.call(e, st);
      // You can show a SnackBar here if you want
    } finally {
      if (!mounted) return;
      setState(() => _downloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disable = widget.disabled || _downloading;

    // replicate MyButton color logic lightly
    Color c = widget.color ?? Theme.of(context).colorScheme.primary;
    Color backgroundColor = (!widget.reverse) ? c : Colors.transparent;
    Color fg = (widget.reverse) ? c : Colors.white;
    Color? borderColor = widget.borderSide?.color;

    if (widget.reverse) {
      final tmp = c;
      c = fg;
      fg = tmp;
    }
    if (widget.fade) backgroundColor = backgroundColor.withOpacity(0.3);
    fg = widget.textColor ?? fg;

    if (disable) {
      backgroundColor = const Color(0xffECECEC);
      fg = Colors.black12;
      borderColor = Colors.black12;
    }

    final shape = RoundedRectangleBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
      side: (widget.borderSide ?? BorderSide.none).copyWith(color: borderColor),
    );

    final button = SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: disable ? null : _startDownload,
        style: widget.style ??
            ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size.fromHeight(widget.height)),
              shape: WidgetStatePropertyAll(shape),
              padding: WidgetStatePropertyAll(
                widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
              ),
              shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              backgroundColor: WidgetStatePropertyAll(backgroundColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.transparent),
            ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ✅ progress fill (animated)
            if (_downloading)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: (widget.borderRadius ?? BorderRadius.circular(widget.radius)),
                  child: AnimatedBuilder(
                    animation: _pulse,
                    builder: (_, __) {
                      // small pulsing to show life even when total is unknown
                      final pulse = 0.85 + _pulse.value * 0.15;

                      return Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: math.max(_progress, 0.04) * pulse,
                          child: Container(
                            color: fg.withOpacity(widget.reverse ? 0.18 : 0.22),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

            // ✅ content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _downloading
                  ? Row(
                key: const ValueKey('downloading'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitThreeBounce(color: fg, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    widget.showPercent ? _percentText() : 'Downloading...',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: fg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
                  : Row(
                key: const ValueKey('idle'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.iconInRight || widget.icon == null
                      ? const SizedBox()
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(widget.icon, color: fg, size: widget.iconSize),
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: fg,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  !widget.iconInRight || widget.icon == null
                      ? const SizedBox()
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(widget.icon, color: fg, size: widget.iconSize),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return button;
  }
}
