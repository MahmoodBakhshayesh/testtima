// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../core/utils_and_services/timatic/artemis_timatic.dart';
// import 'MyTextFieldNew.dart';
//
// const durationUnitsArray = ['HOURS', "DAYS", "WEEKS", "MONTHS", "YEARS"];
//
// class DurationOfStayPickerWeb extends StatefulWidget {
//   final ValueChanged<DurationOfStay?>? onChange;
//   final DurationOfStay? value;
//   final String? label;
//   final String? placeholder;
//   final bool locked;
//   final bool required;
//   final bool labelInRow;
//   final double? height;
//   final TextStyle? style;
//   final List<int> rowLabelRatio;
//   final BorderRadius? radius;
//
//   const DurationOfStayPickerWeb({
//     super.key,
//     this.locked = false,
//     this.rowLabelRatio = const [12, 33],
//     this.required = false,
//     this.labelInRow = false,
//     this.style,
//     this.height,
//     this.radius,
//     required this.label,
//     this.placeholder,
//     this.onChange,
//     this.value,
//   });
//
//   @override
//   State<DurationOfStayPickerWeb> createState() => _DurationOfStayPickerWebState();
// }
//
// class _DurationOfStayPickerWebState extends State<DurationOfStayPickerWeb> {
//   late TextEditingController _durationController;
//   String? _selectedUnit;
//   final _dropdownKey = GlobalKey<DropdownSearchState<String>>();
//
//   @override
//   void initState() {
//     super.initState();
//     _durationController = TextEditingController();
//     _updateStateFromWidget(null);
//     _durationController.addListener(_onChanged);
//   }
//
//   @override
//   void didUpdateWidget(covariant DurationOfStayPickerWeb oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.value != oldWidget.value) {
//       _updateStateFromWidget(oldWidget);
//     }
//   }
//
//   void _updateStateFromWidget(DurationOfStayPickerWeb? oldWidget) {
//     final text = widget.value?.duration.toString() ?? '';
//     if (_durationController.text != text) {
//       _durationController.text = text;
//     }
//
//     if (_selectedUnit != widget.value?.timeUnit) {
//       setState(() {
//         _selectedUnit = widget.value?.timeUnit;
//       });
//     }
//   }
//
//   void _onChanged() {
//     final duration = int.tryParse(_durationController.text);
//     final unit = _selectedUnit;
//
//     DurationOfStay? newValue;
//     if (duration != null && unit != null) {
//       newValue = DurationOfStay(duration: duration, timeUnit: unit);
//     }
//
//     if (widget.value != newValue) {
//       widget.onChange?.call(newValue);
//     }
//   }
//
//   @override
//   void dispose() {
//     _durationController.removeListener(_onChanged);
//     _durationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final content = Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 2,
//           child: MyTextFieldNew(
//             controller: _durationController,
//             label: null, // label is handled by the wrapper
//             placeholder: "e.g. 3",
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             locked: widget.locked,
//             height: widget.height,
//             radius: widget.radius,
//             fontSize: 14,
//             style: widget.style,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           flex: 3,
//           child: SizedBox(
//             height: widget.height ?? 58, // Match MyTextFieldNew default height approx
//             child: DropdownSearch<String>(
//               key: _dropdownKey,
//               items: durationUnitsArray,
//               selectedItem: _selectedUnit,
//               enabled: !widget.locked,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedUnit = value;
//                 });
//                 _onChanged();
//               },
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: widget.radius ?? BorderRadius.circular(5),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   labelText: "Unit",
//                 ),
//               ),
//               popupProps: const PopupProps.menu(
//                 showSearchBox: false,
//                 fit: FlexFit.loose,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//
//     if (widget.labelInRow) {
//       return Row(
//         children: [
//           Expanded(flex: widget.rowLabelRatio[0], child: Text(widget.label ?? '', style: widget.style)),
//           const SizedBox(width: 12),
//           Expanded(flex: widget.rowLabelRatio[1], child: content),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.label != null) ...[
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Text(widget.label!, style: widget.style),
//             ),
//           ],
//           content,
//         ],
//       );
//     }
//   }
// }
