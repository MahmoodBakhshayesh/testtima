import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionChip extends StatelessWidget {
  final String label;
  final bool value;
  final TextStyle? style;
  final void Function(bool)? onSelected;

  const SelectionChip({super.key, required this.label, required this.value, this.onSelected, this.style});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        selectedColor: Colors.green,
        disabledColor: Colors.black,
        backgroundColor: Colors.black26,
        showCheckmark: false,
        visualDensity: VisualDensity.compact,
        selected: value,
        padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
        label: Text(label, style: style??GoogleFonts.robotoCondensed()),
        onSelected: onSelected);
  }
}
