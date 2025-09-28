// GENERATED FROM Styles.css without dx/opacity; alpha baked into color; supports optional per-layer color overrides
import 'package:flutter/widgets.dart';


class LayerSpec {
  final IconData icon;
  final Color color;     // default CSS color with alpha baked in
  const LayerSpec(this.icon, this.color);
}

class LayeredIcon extends StatelessWidget {
  final double size;
  final List<LayerSpec> layers;
  /// Optional color overrides for layers (0-based). If null/shorter, remaining layers use default CSS colors.
  final List<Color>? colors;
  final Color? baseColor;

  const LayeredIcon({
    super.key,
    required this.layers,
    this.size = 24,
    this.colors,
    this.baseColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < layers.length; i++)
            Icon(
              layers[i].icon,
              size: size,
              color: ((colors != null && i < colors!.length) ? colors![i] :baseColor?? layers[i].color.withOpacity(0.25)),
            ),
        ],
      ),
    );
  }
}

class IcomoonLayeredCss {
  static const String _fontFamily = 'Icomoon';

  static LayeredIcon aave_aave({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed00, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed01, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon activity({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed02, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed03, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed08, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed09, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon add_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed04, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed05, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon add_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed06, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed07, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon additem({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed0a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed0b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed0c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon airdrop({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed0d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed0e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed0f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed10, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon airplane({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed13, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed14, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon airplane_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed11, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed12, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon airpod({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed15, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed16, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon airpods({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed17, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed18, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed19, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed1a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed1b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed1c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon alarm({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed1d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed1e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed1f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed20, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed21, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon align_bottom({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed22, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed23, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed24, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon align_horizontally({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed25, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed26, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed27, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed28, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed29, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon align_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed2a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed2b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed2c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon align_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed2d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed2e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed2f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon align_vertically({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed30, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed31, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed32, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed33, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed34, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon android({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed35, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed36, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed37, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed38, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed39, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed3a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon ankr_ankr({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed3b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed3c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed3d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon apple({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed3e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed3f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon aquarius({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed40, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed41, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon archive({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed53, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed54, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed55, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed42, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed43, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed44, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed45, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed46, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed47, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_book({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed48, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed49, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed4a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed4b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed4c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed4d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed4e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed4f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed50, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon archive_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed51, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed52, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrange_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed59, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed5a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed5b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrange_circle_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed56, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed57, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed58, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrange_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed5f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed60, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed61, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrange_square_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed5c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed5d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed5e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed9e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed9f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeda0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeda1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeda2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeda3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed62, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed63, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed64, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed65, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon arrow_bottom({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed66, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed67, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon arrow_circle_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed68, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed69, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_circle_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed6a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed6b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_circle_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed6c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed6d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_circle_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed6e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed6f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed74, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed75, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_down_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed70, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed71, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_down_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed72, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed73, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed7c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed7d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_left_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed76, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed77, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_left_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed78, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed79, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon arrow_left_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed7a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed7b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed84, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed85, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_right_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed7e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed7f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_right_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed80, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed81, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon arrow_right_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed82, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed83, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed8e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed8f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_square_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed86, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed87, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_square_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed88, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed89, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_square_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed8a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed8b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_square_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed8c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed8d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_swap({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed93, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed94, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed95, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_swap_horizontal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed90, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed91, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed92, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed9c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed9d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_up_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed96, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed97, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon arrow_up_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed98, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xed99, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon arrow_up_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xed9a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xed9b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon attach_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeda4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeda5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon attach_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeda6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeda7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon audio_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeda8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeda9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon augur_rep({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedaa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedab, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedac, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon autobrightness({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedad, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedae, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedaf, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon autonio_niox({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedb0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedb1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedb2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedb3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon avalanche_avax({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedb4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedb5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedb6, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon award({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedb7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedb8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedb9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon back_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedba, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedbb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon backward({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedc7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedc8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon backward_10_seconds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedbe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedbf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedc0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon backward_15_seconds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedc1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedc2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedc3, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon backward_5_seconds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedbc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedbd, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon backward_item({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedc4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedc5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedc6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeddd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedde, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedc9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedca, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedcf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedd0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_cross_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedcb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedcc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedcd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedce, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_happy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedd1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedd2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedd7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedd8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_tick_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedd3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedd4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedd5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedd6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bag_timer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedd9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedda, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeddb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeddc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bank({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeddf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xede0, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xede1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xede2, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xede3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xede4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xede5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon barcode({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xede6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xede7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xede8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xede9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedeb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeded, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon battery_charging({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedee, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedef, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedf0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon battery_disable({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedf1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedf2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedf3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedf4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon battery_empty({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedf8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedf9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon battery_empty_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedf5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedf6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedf7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon battery_full({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedfa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xedfb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedfc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedfd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xedfe, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon be({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xedff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee00, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee01, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bezier({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee02, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee03, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee04, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee05, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee06, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee07, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xee08, fontFamily: _fontFamily), const Color(0x29171717)),
      ],
    );
  }

  static LayeredIcon bill({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee09, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee0a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee0b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee0c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon binance_coin_bnb({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee0d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee0e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee0f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee10, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee11, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon binance_usd_busd({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee12, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee13, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee14, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee15, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon bitcoin_btc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee16, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee17, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bitcoin_card({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee18, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee19, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee1a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bitcoin_convert({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee1b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee1c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee1d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee1e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee1f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bitcoin_refresh({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee20, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee21, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee22, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon blend({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee28, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee29, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon blend_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee23, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee24, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee25, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee26, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee27, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon blogger({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee2a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee2b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon bluetooth({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee34, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee35, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bluetooth_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee2c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee2d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee2e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee2f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bluetooth_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee30, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee31, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bluetooth_rectangle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee32, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee33, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon blur({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee36, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee37, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon book({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee42, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee43, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee44, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee45, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon book_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee38, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee39, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee3a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee3b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon book_saved({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee3c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee3d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee3e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon book_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee3f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee40, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee41, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bookmark({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee48, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee49, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bookmark_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee46, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee47, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon bootstrap({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee4a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee4b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon box({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee6c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee6d, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xee6e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon box_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee4c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee4d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee4e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee4f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee50, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon box_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee51, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee52, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee53, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee54, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee55, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee56, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee57, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon box_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee58, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee59, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee5a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee5b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon box_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee5c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee5d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee5e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee5f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon box_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee60, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee61, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee62, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee63, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon box_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee64, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee65, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee66, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee67, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon box_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee68, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee69, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee6a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee6b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon briefcase({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee6f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee70, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon brifecase_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee71, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee72, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee73, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon brifecase_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee74, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee75, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee76, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon brifecase_timer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee77, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee78, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee79, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon broom({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee7a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee7b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee7c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee7d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee7e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee7f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon brush({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee8d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee8e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee8f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon brush_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee80, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee81, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee82, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon brush_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee83, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee84, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee85, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee86, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon brush_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee87, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee88, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee89, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee8a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon brush_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee8b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee8c, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon bubble({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee90, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee91, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee92, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon bucket({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee99, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee9a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee9b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee9c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bucket_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee93, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee94, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee95, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bucket_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee96, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee97, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee98, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon building({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeea7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeea8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeea9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeaa, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xeeab, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeac, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon building_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xee9d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xee9e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xee9f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeea0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeea1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon building_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeea2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeea3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeea4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeea5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeea6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon buildings({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeeb3, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xeeb4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeb5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeeb6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeb7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeb8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon buildings_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeead, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeeaf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeb0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeb1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeb2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon buliding({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeeb9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeba, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeebb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeebc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeebd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeebe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeebf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeec0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon bus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeec1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeec2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeec3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeec4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeec5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon buy_crypto({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeec6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeec7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeec8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cake({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeec9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeca, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeecb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeecc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeecd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeece, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon calculator({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeecf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeed0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeefc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeefd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeefe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef00, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef01, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef02, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef03, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeed7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeed9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeeda, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeedb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeedc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeedd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeede, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeedf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeee0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeee1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeee2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeee3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeee4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeee5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeee6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeee7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeee8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeee9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeeea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeeb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeeec, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeeed, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeeee, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeeef, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeef0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeef1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeef2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeef3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeef4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeef5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon calendar_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeef6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeef7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeef8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeef9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeefa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeefb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef1d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef1e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef04, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef05, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef06, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_calling({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef07, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef08, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef09, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef0a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_incoming({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef0b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef0c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef0d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef0e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef0f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef10, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_outgoing({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef11, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef12, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef13, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_received({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef14, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef15, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef16, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef17, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef18, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef19, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon call_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef1a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef1b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef1c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon camera({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef25, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef26, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef27, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon camera_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef1f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef20, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef21, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef22, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef23, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef24, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon candle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef2a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef2b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon candle_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef28, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef29, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon car({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef2c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef2d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef2e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef2f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef5c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef5d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef5e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef5f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef30, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef31, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef32, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_coin({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef33, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef34, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef35, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef36, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef37, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef38, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef39, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef3a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef3b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_pos({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef3c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef3d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef3e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef3f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef40, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_receive({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef41, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef42, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef43, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef47, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef48, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef49, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef4a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_remove_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef44, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef45, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef46, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_send({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef4b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef4c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef4d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef4e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef4f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef50, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef51, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef52, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef53, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef54, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef58, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef59, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef5a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef5b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon card_tick_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef55, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef56, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef57, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cardano_ada({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef60, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef61, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef62, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef63, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef64, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef65, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef66, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef67, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef68, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef69, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef6a, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef6b, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xef6c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef6d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef6e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef6f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef70, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef71, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef72, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef73, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef74, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef75, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef76, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef77, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef78, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef79, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef7a, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef7b, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef7c, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xef7d, fontFamily: _fontFamily), const Color(0x29171717)),
      ],
    );
  }

  static LayeredIcon cards({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef7e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef7f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef80, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef81, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef82, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon category({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef87, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef88, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef89, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef8a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon category_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef83, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef84, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef85, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef86, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cd({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef8b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef8c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon celo_celo({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef8d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef8e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon celsius_cel({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef8f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef90, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef91, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chart({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefab, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefad, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chart_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef93, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef94, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef95, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef96, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chart_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef97, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef98, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef99, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chart_21({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef9e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef9f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefa0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefa1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chart_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xef9a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef9b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xef9c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xef9d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon chart_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefa2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefa3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefa4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefa5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chart_success({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefa6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefa7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefa8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefa9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefaa, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon check({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefae, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefaf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefb0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefb1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon chrome({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefb2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefb3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon civic_cvc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefb4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefb5, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon clipboard({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefc6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefc7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefc8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clipboard_close({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefb6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefb7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefb8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clipboard_export({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefb9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefba, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefbb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clipboard_import({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefbc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefbd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefbe, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clipboard_text({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefbf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefc0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefc1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefc2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clipboard_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefc3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefc4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefc5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clock({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefcb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefcc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefcd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefce, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon clock_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefc9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefca, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon close_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefcf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefd0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon close_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefd1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefd2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeff0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeff1, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon cloud_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefd3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefd4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_change({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefd5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefd6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefd7, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon cloud_connection({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefd8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefd9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefda, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefdb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon cloud_drizzle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefdc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefdd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_fog({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefde, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefdf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefe0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefe1, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon cloud_lightning({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefe2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefe3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefe4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefe5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_notif({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefe6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefe7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_plus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefe8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xefe9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon cloud_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefea, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefeb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_snow({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefec, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefed, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cloud_sunny({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xefee, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefef, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon code({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeffa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeffb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeffc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon code_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeff2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeff3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeff4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeff5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon code_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeff6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeff7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeff8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeff9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon coffee({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xeffd, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xeffe, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xefff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf000, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf001, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf002, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon coin({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf006, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf007, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf008, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon coin_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf003, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf004, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf005, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon color_swatch({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf009, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf00a, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf00b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon colorfilter({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf00c, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf00d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf00e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon colors_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf00f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf010, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf011, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf012, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon command({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf019, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf01a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf01b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf01c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf01d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon command_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf013, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf014, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf015, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf016, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf017, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf018, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon computing({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf01f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf020, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf021, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf022, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon convert({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf031, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf032, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf033, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon convert_3d_cube({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf023, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf024, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf025, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf026, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf027, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf028, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf029, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf02a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon convert_card({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf02b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf02c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf02d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf02e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf02f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf030, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon convertshape({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf038, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf039, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf03a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf03b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon convertshape_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf034, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf035, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf036, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf037, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon copy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf03e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf03f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon copy_success({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf03c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf03d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon copyright({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf040, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf041, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon courthouse({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf042, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf043, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cpu({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf05e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf05f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf060, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf061, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf062, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf063, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf064, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf065, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf066, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf067, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf068, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf069, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf06a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf06b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cpu_charge({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf044, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf045, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf046, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf047, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf048, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf049, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf04a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf04b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf04c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf04d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf04e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf04f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf050, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf051, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cpu_setting({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf052, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf053, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf054, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf055, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf056, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf057, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf058, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf059, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf05a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf05b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf05c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf05d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon creative_commons({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf06c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf06d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf06e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon crop({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf06f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf070, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf071, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon crown({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf075, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf076, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon crown_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf072, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf073, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf074, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon cup({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf077, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf078, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf079, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf07a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf07b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon d_cube_scan({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xecea, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xeceb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xecec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xeced, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecee, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon d_rotate({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xecef, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecf0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecf1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xecf2, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon d_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xecf3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xecf4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecf5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecf6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dai_dai({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf07c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf07d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf07e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf07f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon danger({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf080, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf081, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf082, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dash_dash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf083, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf084, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon data({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf08a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf08b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf08c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf08d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf08e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon data_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf085, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf086, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf087, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf088, fontFamily: _fontFamily), const Color(0x5e171717)),
        LayerSpec(IconData(0xf089, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon data_21({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfb44, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfb45, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfb46, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfb47, fontFamily: _fontFamily), const Color(0xf5171717)),
        LayerSpec(IconData(0xfb48, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dcube({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xecf7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecf8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xecf9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon decred_dcr({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf08f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf090, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon dent_dent({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf091, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf092, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon designtools({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf093, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf094, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf095, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf096, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf097, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon device_message({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf098, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf099, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf09a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf09b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf09c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf09d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon devices({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0a2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0a3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon devices_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf09e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf09f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0a0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0a1, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon diagram({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0aa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0ab, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon diamonds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0ac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0ad, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon direct({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0c1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0c2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0c3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0c4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon direct_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0ae, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0af, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon direct_inbox({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0b0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0b1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0b2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon direct_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0b3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0b4, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon direct_normal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0b5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0b6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon direct_notification({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0b7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0b8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0b9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon direct_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0ba, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0bb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon direct_send({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0bc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0bd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0be, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon direct_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0bf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0c0, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon directbox_default({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0c5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0c6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0c8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon directbox_notif({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0c9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0ca, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0cb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon directbox_receive({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0cd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0ce, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0cf, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon directbox_send({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0d0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0d1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0d2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0d3, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon discount_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0d4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0d5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0d6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0d7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon discount_shape({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0d8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0da, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0db, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon discover({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0de, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0df, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon discover_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0dc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0dd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dislike({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0e0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0e1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf114, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf115, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf116, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0e2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0e3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_cloud({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0e4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0e5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0e6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_code({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0ea, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0eb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0ec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0ed, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_code_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0e7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0e8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0e9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_copy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0ee, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0ef, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0f0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_download({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0f1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0f2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0f3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0f4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0f5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0f6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_filter({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0f7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0f8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0f9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0fa, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_forward({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0fb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0fc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf0fd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_like({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf0fe, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf0ff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf100, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_normal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf101, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf102, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_previous({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf103, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf104, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf105, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_sketch({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf106, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf107, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf108, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_text({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf10d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf10e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf10f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf110, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_text_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf109, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf10a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf10b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf10c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon document_upload({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf111, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf112, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf113, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dollar_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf117, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf118, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dollar_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf119, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf11a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon dribbble({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf11b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf11c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf11d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf11e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf11f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf120, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon driver({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf130, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf131, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf132, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf133, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf134, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf135, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf136, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf137, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon driver_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf121, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf122, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf123, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf124, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf125, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf126, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf127, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf128, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon driver_refresh({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf129, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf12a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf12b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf12c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf12d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf12e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf12f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon driving({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf138, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf139, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf13a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf13b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf13c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf13d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf13e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf13f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon drop({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf140, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf141, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon dropbox({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf142, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf143, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf144, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf145, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf146, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf14a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf14b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf14c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon edit_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf147, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf148, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf149, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon educare_ekt({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf14d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf14e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf14f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf150, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon electricity({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf151, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf152, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf153, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf154, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon element_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf155, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf156, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf157, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon element_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf158, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf159, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf15a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon element_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf15b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf15c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf15d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf15e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon element_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf15f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf160, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf161, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf162, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon element_equal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf163, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf164, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf165, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf166, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf167, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon element_plus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf168, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf169, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf16a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf16b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon emercoin_emc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf16c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf16d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon emoji_happy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf16e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf16f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf170, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf171, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon emoji_normal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf172, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf173, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf174, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf175, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon emoji_sad({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf176, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf177, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf178, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf179, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon empty_wallet({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf193, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf194, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf195, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf196, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon empty_wallet_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf17a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf17b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf17c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf17d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf17e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon empty_wallet_change({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf17f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf180, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf181, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf182, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf183, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon empty_wallet_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf184, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf185, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf186, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf187, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf188, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon empty_wallet_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf189, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf18a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf18b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf18c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf18d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon empty_wallet_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf18e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf18f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf190, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf191, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf192, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon enjin_coin_enj({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf197, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf198, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon eos_eos({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf199, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf19a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf19b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon eraser({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf19f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1a0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1a1, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon eraser_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf19c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf19d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf19e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ethereum_classic_etc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1a6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1a7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ethereum_eth({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1a2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1a3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1a4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon export({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1af, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon export_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1a8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1a9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon export_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1aa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1ab, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon export_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ac, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1ad, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon external_drive({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1b0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1b1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1b2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1b3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1b4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon eye_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1b5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1b6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1b7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1b8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1b9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon facebook({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ba, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1bb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon fatrows({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1bc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1bd, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon favorite_chart({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1be, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1bf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1c0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon figma({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1c8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1c9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1ca, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1cb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon figma_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1c1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1c2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1c3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1c4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1c5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1c6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon filter({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1d8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1d9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon filter_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1cd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon filter_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ce, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1cf, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon filter_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1d0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1d1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon filter_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1d2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1d3, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon filter_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1d4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1d5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon filter_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1d6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1d7, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon finger_cricle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1da, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1db, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1dc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon finger_scan({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1dd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1de, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1df, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1e0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1e1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1e2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon firstline({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1e3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1e4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1e5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1e6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1e7, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon flag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1eb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon flag_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1e8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1e9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon flash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1f7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1f8, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon flash_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1ed, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1ee, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1ef, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon flash_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1f2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1f3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon flash_circle_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1f0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1f1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon flash_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1f4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf1f5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1f6, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon folder({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf209, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf20a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon folder_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1f9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1fa, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1fb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1fc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_cloud({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1fd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf1fe, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_connection({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf1ff, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf200, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf201, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf202, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf203, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf204, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf205, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf206, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon folder_open({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf207, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf208, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon forbidden({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf20d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf20e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon forbidden_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf20b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf20c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon format_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf20f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf210, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf211, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf212, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf213, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon format_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf214, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf215, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf216, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf217, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf218, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon forward({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf226, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf227, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon forward_10_seconds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf21b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf21c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf21d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon forward_15_seconds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf21e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf21f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf220, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon forward_5_seconds({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf219, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf21a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon forward_item({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf221, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf222, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf223, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon forward_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf224, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf225, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf240, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf241, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf242, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf243, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf228, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf229, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon frame_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf22a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf22b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon frame_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf22c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf22d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon frame_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf22e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf22f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf230, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame_5({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf231, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf232, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf233, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame_6({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf234, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf235, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame_7({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf236, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf237, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf238, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame_8({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf239, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf23a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf23b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf23c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf23d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon frame_9({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf23e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf23f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon framer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf244, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf245, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon ftx_token_ftt({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf246, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf247, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf248, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf249, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon full({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa37, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa38, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa39, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa3a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf267, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf268, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf269, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf24a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf24b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf24c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf24d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf24e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf24f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf250, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf251, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf252, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf253, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf254, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf255, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_import({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf256, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf257, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf258, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf259, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf25a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf25b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf25c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf25d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf25e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf25f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf260, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf261, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf262, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gallery_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf263, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf264, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf265, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf266, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon game({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf26a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf26b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf26c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf26d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf26e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf26f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf270, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gameboy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf271, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf272, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf273, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf274, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf275, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gas_station({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf276, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf277, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf278, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf279, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf27a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gas_station_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xea9a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xea9b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xea9c, fontFamily: _fontFamily), const Color(0x57171717)),
        LayerSpec(IconData(0xea9d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xea9e, fontFamily: _fontFamily), const Color(0x57171717)),
      ],
    );
  }

  static LayeredIcon gemini({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf27d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf27e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf27f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf280, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf281, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon gemini_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf27b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf27c, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon ghost({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf282, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf283, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf284, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gift({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf285, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf286, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf287, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf288, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf289, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon glass({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf28c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf28d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf28e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf28f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf290, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon glass_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf28a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf28b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon global({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2ad, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2ae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2af, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2b0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2b1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2b2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2b3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2b4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2b5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon global_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf291, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf292, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf293, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf294, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf295, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf296, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf297, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf298, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf299, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf29a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon global_refresh({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf29b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf29c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf29d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf29e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf29f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a3, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon global_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2a4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2a9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2aa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2ab, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2ac, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon google({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2bd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2be, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2bf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2c0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2c1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2c2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2c3, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon google_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2b6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2b7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2b8, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon google_play({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2b9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2ba, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2bb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2bc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gps({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2cd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2ce, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2cf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2d0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2d1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon gps_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2c4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2c5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2c6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2c8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2c9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2ca, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2cb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon grammerly({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2d2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2d3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon graph({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2d4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2d5, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon grid_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2d6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2d7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2d8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2da, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2db, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2dc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2dd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2de, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon grid_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2df, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2e0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2e1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2e2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon grid_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2e3, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf2e4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2e5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2e6, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon grid_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2e7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2e8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon grid_5({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2e9, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf2ea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2eb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon grid_6({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2ec, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2ed, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2ee, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2ef, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon grid_7({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2f0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2f1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2f2, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon grid_8({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2f3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2f4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2f5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2f6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2f7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2f8, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon grid_9({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2f9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf2fa, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon grid_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf2fb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2fc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2fd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2fe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf2ff, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf300, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf301, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon grid_eraser({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf302, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf303, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf304, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf305, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf306, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf307, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf308, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf309, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon grid_lock({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf30a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf30b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf30c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf30d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf30e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf30f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf310, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon group({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf319, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf31a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf31b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf31c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf31d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon group_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf311, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf312, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf313, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf314, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf315, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf316, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf317, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf318, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon happyemoji({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf31e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf31f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon harmony_one({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf320, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf321, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf322, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hashtag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf32b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf32c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hashtag_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf323, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf324, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hashtag_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf325, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf326, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf327, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hashtag_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf328, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf329, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf32a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon headphone({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf32d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf32e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf32f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon headphones({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf330, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf331, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf332, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf333, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf334, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf335, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf336, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf337, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon health({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf338, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf339, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf33a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon heart({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf349, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf34a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon heart_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf33b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf33c, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon heart_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf33d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf33e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon heart_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf33f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf340, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon heart_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf341, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf342, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon heart_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf343, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf344, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon heart_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf345, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf346, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon heart_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf347, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf348, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon hedera_hashgraph_hbar({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf34b, fontFamily: _fontFamily), const Color(0xff000000)),
        LayerSpec(IconData(0xf34c, fontFamily: _fontFamily), const Color(0xff000000)),
        LayerSpec(IconData(0xf34d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf34e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf34f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hex_hex({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf350, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf351, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf352, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon hex_hex1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfc09, fontFamily: _fontFamily), const Color(0x21171717)),
        LayerSpec(IconData(0xfc0a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfc0b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfc0c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hierarchy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf362, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf363, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf364, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf365, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon hierarchy_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf353, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf354, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf355, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf356, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon hierarchy_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf357, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf358, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf359, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf35a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon hierarchy_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf35f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf360, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf361, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hierarchy_square_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf35b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf35c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hierarchy_square_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf35d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf35e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf374, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf375, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf366, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf367, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf368, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf369, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home_hashtag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf36a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf36b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home_trend_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf36c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf36d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home_trend_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf36e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf36f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon home_wifi({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf370, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf371, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf372, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf373, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon hospital({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf376, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf377, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf378, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf379, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon house({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf37e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf37f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf380, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf381, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf382, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf383, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon house_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf37a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf37b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf37c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf37d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon html_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf384, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf385, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon html_5({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf386, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf387, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon huobi_token_ht({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf388, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf389, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon icon_icx({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf38a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf38b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf38c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf38d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon illustrator({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf38e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf38f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf390, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf391, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon image({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf392, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf393, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon import({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf398, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf399, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon import_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf394, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf395, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon import_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf396, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf397, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon info_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf39a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf39b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf39c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon information({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf39d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf39e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf39f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon instagram({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3a0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3a1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3a2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon iost_iost({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3a3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3a4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon java_script({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3a6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3a7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon js({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3a8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3a9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon judge({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3aa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3ab, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3ac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3ad, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon kanban({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3ae, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3af, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon key({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3b2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3b3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon key_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3b0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3b1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon keyboard({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3ba, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3bb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3bc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3bd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3be, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon keyboard_open({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3b4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3b5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3b6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3b7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3b8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3b9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon kyber_network_knc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3bf, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf3c0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3c1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3c2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lamp({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3ce, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3cf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3d0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lamp_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3c3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3c4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lamp_charge({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3c5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3c6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3c7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lamp_on({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3c8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3c9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lamp_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3ca, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3cb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3cd, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon language_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3d1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3d2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon language_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3d3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3d4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon layer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3d5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3d6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3d7, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon level({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3d8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3da, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3db, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lifebuoy({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3dc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3dd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon like({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3e8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3e9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon like_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3de, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3df, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon like_dislike({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3e0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3e1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3e2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3e3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon like_shapes({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3e4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3e5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon like_tag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3e6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3e7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon link({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3fa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3fb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3fc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon link_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3ea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3eb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3ec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3ed, fontFamily: _fontFamily), const Color(0x80171717)),
      ],
    );
  }

  static LayeredIcon link_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3ee, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3ef, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3f0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3f1, fontFamily: _fontFamily), const Color(0x80171717)),
      ],
    );
  }

  static LayeredIcon link_21({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3f2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3f3, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon link_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3f4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3f5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3f6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon link_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3f7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3f8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3f9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon litecoinltc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf3fd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf3fe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf3ff, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon location({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf40b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf40c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon location_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf400, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf401, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon location_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf402, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf403, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon location_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf404, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf405, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon location_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf406, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf407, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf408, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon location_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf409, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf40a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lock({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf419, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf41a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf41b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon lock_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf40d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf40e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf40f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf410, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf411, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lock_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf412, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf413, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lock_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf414, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf415, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf416, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf417, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf418, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon login({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf41e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf41f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon login_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf41c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf41d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon logout({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf422, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf423, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon logout_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf420, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf421, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon lovely({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf424, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf425, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon magic_star({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf426, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf427, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon magicpen({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf428, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf429, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf42a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf42b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf42c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon main_component({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf42d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf42e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maker_mkr({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf42f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf430, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf431, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon man({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf432, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf433, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon map({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf437, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf438, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf439, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf43a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf43b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon map_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf434, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf435, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf436, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon mask({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf440, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf441, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mask_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf43c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf43d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mask_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf43e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf43f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon math({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf442, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf443, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf444, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf445, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf446, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf447, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf45b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf45c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf448, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf449, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf44a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf44b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf44c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf44d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf44e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize_21({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf454, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf455, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf456, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf44f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf450, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf451, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf452, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf453, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon maximize_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf457, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf458, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf459, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf45a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon medal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf460, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf461, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon medal_star({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf45d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf45e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf45f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon menu({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf46c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf46d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf46e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf46f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon menu_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf462, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf463, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf464, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf465, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon menu_board({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf466, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf467, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf468, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf469, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf46a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf46b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4a6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4a7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4a8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf470, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf471, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf474, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf475, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf476, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_add_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf472, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf473, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf477, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf478, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf479, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf47a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf47b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf47c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf47d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf47e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf47f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf480, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf481, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf482, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_notif({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf483, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf484, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf485, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf486, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf487, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_programming({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf488, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf489, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf48a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf48b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_question({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf48c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf48d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf48e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf48f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf490, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf491, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf492, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf493, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf494, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf495, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf496, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf497, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf498, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon message_text({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf49c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf49d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf49e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_text_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf499, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf49a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf49b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf49f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4a0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4a1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon message_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4a2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4a3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4a4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon messages({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4b2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4b3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4b4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon messages_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4a9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4aa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ab, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ad, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon messages_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4ae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4af, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon messages_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4b0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4b1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon messenger({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4b5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4b6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon microphone({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4c2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4c3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon microphone_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4b7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4b8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon microphone_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4be, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4bf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4c0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4c1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon microphone_slash_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4b9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ba, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4bb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4bc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4bd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon microscope({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4c4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4c5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4c6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4c7, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon milk({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4c8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4c9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4ca, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mini_music_sqaure({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4cb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4cd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mini_music_sqaure1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfc8f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfc90, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfc91, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4d2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4d3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon minus_cirlce({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4ce, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4cf, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon minus_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4d0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4d1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mirror({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4d4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4d5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mirroring_screen({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4d6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4d7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4d8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4d9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mobile({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4dd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4de, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4df, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mobile_programming({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4da, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4db, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4dc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf513, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf514, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf515, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf516, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4e0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4e1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4e2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4e3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4e4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4e5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4e6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4e7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4e8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4e9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4ea, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4eb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ed, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ee, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4ef, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4f0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4f1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4f2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4f3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_change({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4f4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4f5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4f6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4f7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_forbidden({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4f8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4f9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4fa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4fb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf4fc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_recive({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf4fd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4fe, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf4ff, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf500, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf501, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf502, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf503, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf504, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf505, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf506, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf507, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_send({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf508, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf509, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf50a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf50b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf50c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf50d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf50e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon money_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf50f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf510, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf511, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf512, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon moneys({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf517, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf518, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf519, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf51a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf51b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon monitor({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf522, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf523, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon monitor_mobbile({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf51c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf51d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf51e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon monitor_recorder({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf51f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf520, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf521, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon moon({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf524, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf525, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon more({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf532, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf533, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf534, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf535, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon more_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf526, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf527, fontFamily: _fontFamily), const Color(0xf7171717)),
        LayerSpec(IconData(0xf528, fontFamily: _fontFamily), const Color(0xf7171717)),
        LayerSpec(IconData(0xf529, fontFamily: _fontFamily), const Color(0xf7171717)),
      ],
    );
  }

  static LayeredIcon more_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf52a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf52b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf52c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf52d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon more_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf52e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf52f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf530, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf531, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mouse({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf53c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf53d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mouse_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf536, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf537, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon mouse_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf538, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf539, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon mouse_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf53a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf53b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf563, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf564, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf565, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon music_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf53e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf53f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf540, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf541, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf542, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf543, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_dashboard({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf544, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf545, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf546, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_filter({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf547, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf548, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf549, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf54a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf54b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_library_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf54c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf54d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf54e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf54f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_play({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf550, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf551, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf552, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf553, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_playlist({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf554, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf555, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf556, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf557, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf561, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf562, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_square_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf558, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf559, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf55a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_square_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf55b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf55c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf55d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon music_square_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf55e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf55f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf560, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon musicnote({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf566, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf567, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon nebulas_nas({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf568, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf569, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf56a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf56b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf56c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf56d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon nem_xem({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf56e, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf56f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf570, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon next({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf571, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf572, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf594, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf595, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf596, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf597, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf573, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf574, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf575, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf576, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf577, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf578, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf579, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_21({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf57a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf57b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf57c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf57d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf57e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf57f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf580, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf581, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf582, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf583, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf584, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf585, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf586, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf587, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf588, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf589, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf58a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf58b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf58c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf58d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf58e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon note_text({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf58f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf590, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf591, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf592, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf593, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon notification({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5a6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5a7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5a8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon notification_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf598, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf599, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon notification_bing({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf59a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf59b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf59c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon notification_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf59d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf59e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon notification_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf59f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5a0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5a1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon notification_status({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5a2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5a3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5a4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5a5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ocean_protocol_ocean({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5a9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5aa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5ab, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5ac, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xf5ad, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xf5ae, fontFamily: _fontFamily), const Color(0x0a171717)),
        LayerSpec(IconData(0xf5af, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5b0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5b1, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xf5b2, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xf5b3, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xf5b4, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xf5b5, fontFamily: _fontFamily), const Color(0x0a171717)),
        LayerSpec(IconData(0xf5b6, fontFamily: _fontFamily), const Color(0x0a171717)),
        LayerSpec(IconData(0xf5b7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5b8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5b9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5ba, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5bb, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xf5bc, fontFamily: _fontFamily), const Color(0x5c171717)),
        LayerSpec(IconData(0xf5bd, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xf5be, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xf5bf, fontFamily: _fontFamily), const Color(0x0a171717)),
        LayerSpec(IconData(0xf5c0, fontFamily: _fontFamily), const Color(0x0a171717)),
      ],
    );
  }

  static LayeredIcon okb_okb({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5c1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5c2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5c3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5c4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5c5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5c6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5c8, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon omega_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5c9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5ca, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon omega_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5cb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5cc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ontology_ont({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5cd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5ce, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon paintbucket({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5cf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5d0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5d1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon paperclip({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5d4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5d5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon paperclip_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5d2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5d3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon password_check({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5d6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5d7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5d8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5da, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon path({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5e2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5e3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5e4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon path_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5db, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5dc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5dd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon path_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5de, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5df, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5e0, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf5e1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon pause({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5e8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5e9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon pause_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5e5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5e6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5e7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon paypal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5ea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5eb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon pen_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5ec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5ed, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5ee, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5ef, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon pen_close({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5f0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5f1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5f2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5f3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon pen_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5f4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5f5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5f6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf5f7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon pen_tool({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5ff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf600, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf601, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf602, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf603, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf604, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf605, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf606, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf607, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf608, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon pen_tool_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf5f8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5f9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5fa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5fb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5fc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5fd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf5fe, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon people({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf609, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf60a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf60b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf60c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf60d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf60e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon percentage_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf60f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf610, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf611, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf612, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon percentage_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf613, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf614, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf615, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf616, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon personalcard({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf617, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf618, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf619, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf61a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf61b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf61c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon pet({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf61d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf61e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf61f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf620, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf621, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon pharagraphspacing({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf622, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf623, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf624, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon photoshop({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf625, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf626, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf627, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon picture_frame({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf628, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf629, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon play({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf637, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf638, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon play_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf62a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf62b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf62c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon play_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf62d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf62e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon play_cricle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf62f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf630, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf631, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf632, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf633, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon play_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf634, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf635, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf636, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon polkadot_dot({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf639, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf63a, fontFamily: _fontFamily), const Color(0x29171717)),
      ],
    );
  }

  static LayeredIcon polygon_matic({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf63b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf63c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf63d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon polyswarm_nct({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf63e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf63f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf640, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf641, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon presention_chart({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf642, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf643, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf644, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf645, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon previous({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf646, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf647, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon printer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf650, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf651, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf652, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf653, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf654, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon printer_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf648, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf649, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf64a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf64b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf64c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf64d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf64e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf64f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon profile({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf668, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf669, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon profile_2user({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf655, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf656, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf657, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf658, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon profile_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf659, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf65a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf65b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon profile_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf65c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf65d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf65e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon profile_delete({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf65f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf660, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf661, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon profile_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf662, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf663, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf664, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon profile_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf665, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf666, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf667, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon programming_arrow({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf66a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf66b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon programming_arrows({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf66c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf66d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf66e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf66f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon python({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf670, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf671, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon quant_qnt({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf672, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf673, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf674, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf675, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf676, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf677, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf678, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf679, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon quote_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf680, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf681, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon quote_down_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf67a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf67b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf67c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon quote_down_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf67d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf67e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf67f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon quote_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf688, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf689, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon quote_up_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf682, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf683, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf684, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon quote_up_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf685, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf686, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf687, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon radar({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf691, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf692, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon radar_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf68a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf68b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf68c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf68d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf68e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon radar_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf68f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf690, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon radio({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf693, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf694, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf695, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf696, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf697, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf698, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ram({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf69e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf69f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6a0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ram_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf699, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf69a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf69b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf69c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf69d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ranking({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6a6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6a7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6a8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ranking_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6a1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6a2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6a3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6a4, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon receipt({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6d2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6d3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6d4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6a9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6aa, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon receipt_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6af, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6b0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6b1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6b2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_2_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ab, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6ac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6ad, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6b3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6b4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6b5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_discount({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6b6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6b7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6b8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6b9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6ba, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_disscount({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6bb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6bc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6bd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6be, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6bf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6c0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_item({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6c1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6c2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6c3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6c4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6c5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6c6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6c8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6c9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ca, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6cb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receipt_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6cc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6cd, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon receipt_text({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ce, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6cf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6d0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6d1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receive_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6d8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6da, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon receive_square_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6d5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6d6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6d7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon received({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6db, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6dc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6dd, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon record({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6e0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6e1, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon record_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6de, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6df, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon recovery_convert({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6e2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6e3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6e4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6e5, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon redo({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6e6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6e7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon refresh({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6f4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6f5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6f6, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon refresh_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6e8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6e9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon refresh_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ea, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6eb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6ec, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon refresh_left_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ed, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6ee, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon refresh_right_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ef, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6f0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon refresh_square_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6f1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6f2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6f3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon repeat({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6fa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6fb, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon repeat_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6f7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6f8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf6f9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon repeate_music({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6fc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6fd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf6fe, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon repeate_one({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf6ff, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf700, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf701, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon reserve({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf702, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf703, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf704, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf705, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon rotate_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf708, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf709, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon rotate_left_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf706, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf707, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon rotate_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf70c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf70d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon rotate_right_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf70a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf70b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon route_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf70e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf70f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon routing({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf715, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf716, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf717, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf718, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf719, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon routing_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf710, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf711, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf712, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf713, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf714, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon row_horizontal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf71a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf71b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon row_vertical({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf71c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf71d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ruler({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf71e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf71f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf720, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf721, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf722, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon rulerpen({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf723, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf724, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf725, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf726, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf727, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf728, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf729, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon safe_home({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf72a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf72b, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon sagittarius({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf72c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf72d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon save_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf72e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf72f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon save_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf730, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf731, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf732, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon save_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf733, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf734, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf735, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon save_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf736, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf737, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf738, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon scan({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf741, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf742, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf743, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf744, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf745, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf746, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf747, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon scan_barcode({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf739, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf73a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf73b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf73c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf73d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf73e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf73f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf740, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon scanner({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf748, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf749, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf74a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf74b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf74c, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon scanning({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf74d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf74e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf74f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf750, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf751, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf752, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf753, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf754, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon scissor({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf758, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf759, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon scissor_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf755, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf756, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf757, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon screenmirroring({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf75a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf75b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon scroll({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf75c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf75d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf75e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_favorite({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf762, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf763, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf764, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_favorite_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf75f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf760, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf761, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_normal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf767, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf768, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_normal_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf765, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf766, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_status({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf76d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf76e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf76f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf770, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_status_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf769, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf76a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf76b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf76c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_zoom_in({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf774, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf775, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf776, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_zoom_in_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf771, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf772, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf773, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_zoom_out({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf77a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf77b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf77c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon search_zoom_out_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf777, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf778, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf779, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon security({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf788, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf789, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon security_card({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf77d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf77e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf77f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon security_safe({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf780, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf781, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon security_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf782, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf783, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf784, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon security_user({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf785, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf786, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf787, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon send({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf797, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf798, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon send_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf78a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf78b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf78c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon send_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf78d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf78e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf78f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon send_sqaure_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf790, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf791, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf792, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon send_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf793, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf794, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf795, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf796, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon setting({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7ae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7af, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon setting_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf799, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf79a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon setting_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf79b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf79c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf79d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf79e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf79f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7a0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7a1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon setting_4({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7a2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7a3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7a4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7a6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7a7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon setting_5({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7a8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7a9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7aa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7ab, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7ac, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7ad, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon settings({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7b0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7b1, fontFamily: _fontFamily), const Color(0x29171717)),
        LayerSpec(IconData(0xf7b2, fontFamily: _fontFamily), const Color(0x29171717)),
      ],
    );
  }

  static LayeredIcon shapes({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7b5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7b6, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon shapes_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7b3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7b4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon share({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7b7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7b8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7b9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7ba, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7bb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7bc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shield({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7c9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7ca, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shield_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7bd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7be, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shield_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7bf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7c0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7c1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shield_security({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7c2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7c3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shield_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7c4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7c5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7c6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shield_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7c7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7c8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ship({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7cb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7cd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shop({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7d8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7da, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf7db, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf7dc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shop_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7ce, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7cf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7d0, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf7d1, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf7d2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shop_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7d3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7d4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7d5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7d6, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf7d7, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon shopping_bag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7dd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7de, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7df, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shopping_cart({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7e0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7e1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7e2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7e3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon shuffle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7e4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7e5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7e6, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon siacoin_sc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7e7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7e8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7e9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sidebar_bottom({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7ea, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7eb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7ec, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sidebar_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7ed, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7ee, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7ef, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sidebar_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7f0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7f1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7f2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sidebar_top({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7f3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7f4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7f5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon signpost({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7f6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7f7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7f8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7f9, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon simcard({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7ff, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf800, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf801, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf802, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf803, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon simcard_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7fa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7fb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf7fc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon simcard_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf7fd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf7fe, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon size({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf804, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf805, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon slack({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf806, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf807, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf808, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf809, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf80a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf80b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf80c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf80d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf80e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf80f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf810, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon slider({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf81d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf81e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf81f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf820, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon slider_horizontal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf814, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf815, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf816, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon slider_horizontal_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf811, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf812, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf813, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon slider_vertical({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf81a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf81b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf81c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon slider_vertical_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf817, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf818, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf819, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon smallcaps({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf821, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf822, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf823, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon smart_car({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf824, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf825, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf826, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf827, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf828, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf829, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon smart_home({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf82a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf82b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf82c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf82d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon smileys({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf82e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf82f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf830, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf831, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf832, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf833, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sms({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf843, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf844, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sms_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf834, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf835, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf836, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sms_notification({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf837, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf838, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf839, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sms_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf83a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf83b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf83c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sms_star({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf83d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf83e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf83f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sms_tracking({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf840, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf841, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf842, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon snapchat({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf845, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf846, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon solana_sol({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf847, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf848, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf849, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sort({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf84a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf84b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf84c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf84d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sound({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf84e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf84f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf850, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf851, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf852, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon speaker({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf853, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf854, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf855, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon speedometer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf856, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf857, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf858, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon spotify({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf859, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf85a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf85b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf85c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xecfa, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xecfb, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xecfc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon stacks_stx({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf85d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf85e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf85f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon star({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf867, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf868, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon star_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf860, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf861, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf862, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf863, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon star_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf864, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf865, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf866, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon status({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf86e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf86f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf870, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon status_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf869, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf86a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf86b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf86c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf86d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sticker({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf871, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf872, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon stickynote({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf873, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf874, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf875, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf876, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf877, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf878, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon stop({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf87b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf87c, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon stop_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf879, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf87a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon story({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf87d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf87e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf87f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf880, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon strongbox({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf884, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf885, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon strongbox_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf881, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf882, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf883, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon subtitle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf886, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf887, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf888, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf889, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf88a, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon sun({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf897, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf898, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sun_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf88b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf88c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf88d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf88e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf88f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf890, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf891, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon sun_fog({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf892, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf893, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf894, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf895, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf896, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon support({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xecfd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xecfe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xecff, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8a3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8a4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tag_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf899, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf89a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf89b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tag_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf89c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf89d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tag_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf89e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf89f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon tag_user({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8a0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8a1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8a2, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon task({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8aa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8ab, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8ac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8ad, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8ae, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8af, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon task_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8a5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8a6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8a7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8a8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8a9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon teacher({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8b0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8b1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tenx_pay({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8b2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8b3, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tether_usdt({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8b4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8b5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon text({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8bf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8c0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon text_block({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8b6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8b7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon text_bold({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8b8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8b9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon text_italic({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8ba, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8bb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon text_underline({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8bc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8bd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8be, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon textalign_center({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8c1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8c2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8c3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8c4, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon textalign_justifycenter({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8c5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8c6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8c8, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon textalign_justifyleft({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8c9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8ca, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8cb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8cc, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon textalign_justifyright({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8cd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8ce, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8cf, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8d0, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon textalign_left({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8d1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8d2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8d3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8d4, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon textalign_right({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8d5, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8d6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8d7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8d8, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon the_graph_grt({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8d9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8da, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8db, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8dc, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon theta_theta({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8dd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8de, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon thorchain_rune({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8df, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8e0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tick_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8e1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8e2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tick_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8e3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8e4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ticket({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8f1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8f2, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon ticket_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8e5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8e6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8e7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ticket_discount({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8e8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8e9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8ea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8eb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ticket_expired({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8ec, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8ed, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ticket_star({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8ee, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8ef, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8f0, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon timer({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8fe, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8ff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf900, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon timer_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8f3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8f4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8f5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon timer_pause({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8f6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8f7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8f8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8f9, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon timer_start({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf8fa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8fb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf8fc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf8fd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon toggle_off({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf903, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf904, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon toggle_off_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf901, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf902, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon toggle_on({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf907, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf908, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon toggle_on_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf905, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf906, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon trade({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf909, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf90a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf90b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf90c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon transaction_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf90d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf90e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon translate({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf90f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf910, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf911, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf912, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf913, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf914, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon trash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf915, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf916, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf917, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf918, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon tree({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf919, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf91a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf91b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon trello({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf91c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf91d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf91e, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon trend_down({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf91f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf920, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon trend_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf921, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf922, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon triangle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf926, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf927, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf928, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon triangle_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf923, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf924, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf925, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon trontron_trx({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf929, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf92a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf92b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf92c, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon truck_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf92d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf92e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf92f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf930, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf931, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf932, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon truck_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf933, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf934, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf935, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf936, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf937, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf938, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon truck_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf939, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf93a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf93b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf93c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf93d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf93e, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon trush_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf93f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf940, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf941, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon twitch({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf942, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf943, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf944, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon ui8({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf945, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf946, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf947, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf948, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf949, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf94a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon undo({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf94b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf94c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon unlimited({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf94d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf94e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf94f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon unlock({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf950, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf951, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf952, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon usd_coin_usdc({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf953, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf954, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf955, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf956, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf976, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf977, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf957, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf958, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf959, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_cirlce_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf95a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf95b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf95c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf95d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_edit({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf95e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf95f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf960, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf961, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf962, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf963, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_octagon({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf964, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf965, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf966, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf967, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf968, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf969, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf96a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf96b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf96c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf96d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf96e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf96f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_tag({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf970, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf971, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf972, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon user_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf973, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf974, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf975, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon verify({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf979, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf97a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon vibe_vibe({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf97b, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf97c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf97d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf99d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf99e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf99f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf97e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf97f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf980, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_circle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf981, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf982, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_horizontal({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf983, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf984, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_octagon({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf985, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf986, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_play({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf987, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf988, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf989, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf98a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf98b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf98c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf98d, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf98e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf98f, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf990, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf991, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf992, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_slash1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfdf7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfdf8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfdf9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfdfa, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf993, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf994, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_tick({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf995, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf996, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf997, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_time({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf998, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf999, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf99a, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon video_vertical({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf99b, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf99c, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon voice_cricle({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9a0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9a1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9a2, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9a3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9a4, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9a5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon voice_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9a6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9a7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9a8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9a9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9aa, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9ab, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_cross({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9ac, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9ad, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9ae, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_high({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9af, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9b0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9b1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9b2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_low({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9b6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9b7, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9b8, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_low_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9b3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9b4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9b5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_mute({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9b9, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9ba, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_slash({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9bb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9bc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9bd, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9be, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9bf, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon volume_up({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9c0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9c1, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9c2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon vuesax({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9c3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9c4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9c5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9f0, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9f1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9f2, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9c6, fontFamily: _fontFamily), const Color(0xcc171717)),
        LayerSpec(IconData(0xf9c7, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9c8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9c9, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf9ca, fontFamily: _fontFamily), const Color(0x99171717)),
      ],
    );
  }

  static LayeredIcon wallet_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9cb, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9cc, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9cd, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_3({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9ce, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9cf, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9d0, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9d1, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_add({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9d8, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9d9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9da, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9db, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_add_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9d2, fontFamily: _fontFamily), const Color(0xcc171717)),
        LayerSpec(IconData(0xf9d3, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9d4, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9d5, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf9d6, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf9d7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_check({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9dc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9dd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9de, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9df, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_minus({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9e0, fontFamily: _fontFamily), const Color(0xcc171717)),
        LayerSpec(IconData(0xf9e1, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9e2, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9e3, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf9e4, fontFamily: _fontFamily), const Color(0x99171717)),
        LayerSpec(IconData(0xf9e5, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_money({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9e6, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9e7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_remove({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9e8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9e9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9ea, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9eb, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wallet_search({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9ec, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9ed, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9ee, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9ef, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wanchain_wan({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9f5, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9f6, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9f7, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wanchain_wan_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9f3, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9f4, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon warning_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9f8, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9f9, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9fa, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon watch({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa01, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa02, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa03, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa04, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon watch_status({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xf9fb, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xf9fc, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9fd, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9fe, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xf9ff, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa00, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon weight({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa07, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa08, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa09, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa0a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa0b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon weight_1({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa05, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa06, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon whatsapp({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa0c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa0d, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wifi({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa12, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa13, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa14, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa15, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon wifi_square({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa0e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa0f, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa10, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa11, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wind({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa19, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa1a, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa1b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon wind_2({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa16, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa17, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa18, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon windows({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa1c, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa1d, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa1e, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa1f, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon wing_wing({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa20, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa21, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa22, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon woman({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa23, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa24, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon xd({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa25, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa26, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa27, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon xiaomi({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa28, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa29, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa2a, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa2b, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon xrp_xrp({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa2c, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa2d, fontFamily: _fontFamily), const Color(0x66171717)),
      ],
    );
  }

  static LayeredIcon youtube({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa2e, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa2f, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon zel_zel({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa30, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa31, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa32, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa33, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

  static LayeredIcon zoom({double size = 24, List<Color>? colors,Color? baseColor}) {
    return LayeredIcon(
      size: size,
      colors: colors,
      baseColor: baseColor,
      layers: [
        LayerSpec(IconData(0xfa34, fontFamily: _fontFamily), const Color(0x66171717)),
        LayerSpec(IconData(0xfa35, fontFamily: _fontFamily), const Color(0xff171717)),
        LayerSpec(IconData(0xfa36, fontFamily: _fontFamily), const Color(0xff171717)),
      ],
    );
  }

}
