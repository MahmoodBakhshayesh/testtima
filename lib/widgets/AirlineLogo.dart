import 'dart:convert';
import 'dart:developer';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:flutter/foundation.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/classes/basic_class.dart';
import '../core/constants/apis.dart';
import '../core/constants/ui.dart';
import '../core/data_base/local_data_base.dart';
import '../core/data_base/table_names.dart';

class AirlineLogo extends StatefulWidget {
  final String al;
  final double size;
  final EdgeInsetsGeometry? padding;

  const AirlineLogo(this.al, {super.key, this.size = 40, this.padding = const EdgeInsets.all(4)});

  // const AirlineLogo({Key? key}) : super(key: key);

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
          return Icon(Icons.error, color: Colors.red);
        },
        loadingBuilder: (context, progress) {
          return Container(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: 120, height: 120, child: CircularProgressIndicator(color: context.mainColor, value: progress.progressPercentage.value)),
              ],
            ),
          );
        },
      ),
    );
  }
}
