import 'dart:ui';
import 'package:flutter/material.dart';

class FigmaGlass extends StatelessWidget {
  const FigmaGlass({
    super.key,
    this.child,
    this.width = 200,
    this.height = 136,
  });

  final Widget? child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    const radius = 28.0;

    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        boxShadow: [
          // subtle lift; optional
          BoxShadow(blurRadius: 50, spreadRadius: -20, offset: Offset(0, 0),color: Colors.white),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            // 1) Background blur (the key to glass)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox.expand(),
            ),

            // 2) Translucent inner fill gradient: #2A5CFF -> #535353
            //    Keep very low alpha for a realistic frosted look.
            Container(
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2A5CFF).withOpacity(0.9), // start
                    Color(0xFFF0F0F1),
                  ],
                ).scale(0.2), // <— reduce opacity uniformly
                borderRadius: BorderRadius.circular(radius),
              ),
            ),

            // 3) 1px gradient stroke: #B3C5FF -> #F0F0F1
            //    Border gradients need painting manually.
            CustomPaint(
              painter: _GradientBorderPainter(
                strokeWidth: 0,
                radius: radius,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFB3C5FF),
                    Color(0xFFF0F0F1),
                  ],
                ),
              ),
              child: Padding(
                // Figma shows 15px top padding; add a nice base padding for sides
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Paints a rounded-rect gradient stroke.
class _GradientBorderPainter extends CustomPainter {
  _GradientBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  final double strokeWidth;
  final double radius;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2), // keep stroke fully visible
      Radius.circular(radius),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) =>
      oldDelegate.strokeWidth != strokeWidth ||
          oldDelegate.radius != radius ||
          oldDelegate.gradient != gradient;
}
