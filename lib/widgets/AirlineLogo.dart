import 'package:abds/core/extenstions/context_exp.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
class AirlineLogo extends StatefulWidget {
  final String al;
  final double size;
  final EdgeInsetsGeometry? padding;

  const AirlineLogo(this.al, {super.key, this.size = 40, this.padding = const EdgeInsets.all(4)});


  @override
  State<AirlineLogo> createState() => _AirlineLogoState();
}

class _AirlineLogoState extends State<AirlineLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.size,
      height: widget.size,
      child: FastCachedImage(
        url: "https://imagedcs.abomis.com/api/airlineimage/${widget.al}",
        fit: BoxFit.contain,
        headers: {
          "Key": "0F58FF9A-C05B-4FDD-A6A5-5E8D1A102C75",
        },
        fadeInDuration: const Duration(milliseconds: 300),
        errorBuilder: (context, exception, stacktrace) {
          // log("${exception}");
          return Icon(Icons.error, color: Colors.transparent,size: 10,);
        },
        loadingBuilder: (context, progress) {
          return Container(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: context.mainColor, value: progress.progressPercentage.value)),
              ],
            ),
          );
        },
      ),
    );
  }
}
