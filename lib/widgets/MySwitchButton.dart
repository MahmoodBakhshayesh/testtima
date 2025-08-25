import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MySwitchButton extends StatelessWidget {
  final bool value;
  final bool disabled;
  final void Function(bool v) onChanged;
  final String label;
  final Widget? labelWidget;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const MySwitchButton({super.key, this.labelWidget, required this.value, required this.onChanged, required this.label, this.color, this.padding, this.backgroundColor, this.height = 45, this.disabled=false,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: color ?? MyColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed:disabled?null: () {
          onChanged(!value);
        },
        child: Row(
          children: [
            Expanded(child: labelWidget ?? Text(label,style: TextStyle(fontSize: 11),)),
            SizedBox(
              child: CupertinoSwitch(
                value: value,

                onChanged:disabled?null: onChanged,
                activeColor: color ?? MyColors.green,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
