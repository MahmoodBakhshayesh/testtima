import 'dart:math';
import 'dart:developer' as dev;
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_view_desktop.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/ui.dart';
import '../core/utils_and_services/keyboard/lib/keyboard_actions.dart';
import '../core/utils_and_services/keyboard/lib/keyboard_actions_item.dart';
import 'number_input_sheet.dart';

final globalFormValidationMode = StateProvider<bool>((ref) => false);

class MyTextFieldNew extends ConsumerStatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFn;
  final FocusNode? prevFn;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String v)? validator;
  final double? fontSize;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final ValueChanged<String>? onSubmit;
  final String? placeholder;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final IconData? validationIcon;
  final ValueChanged<String>? onChanged;
  final bool showClearButton;
  final bool locked;
  final bool openNumberSheet;
  final bool showLimit;
  final bool required;
  final bool disabled;
  final bool labelInRow;
  final bool showError;
  final Color? validationColor;
  final Color? backgroundColor;
  final Color? headerBgColor;
  final Color? bodyBgColor;
  final BorderRadius? radius;
  final double? height;
  final double? suffixWidth;
  final BorderSide? borderSide;
  final List<int> rowLabelRatio;

  const MyTextFieldNew({
    Key? key,
    this.label,
    this.headerBgColor,
    this.bodyBgColor,
    this.nextFn,
    this.rowLabelRatio = const [12, 33],
    this.validationColor,
    this.backgroundColor,
    this.prevFn,
    this.labelInRow = true,
    this.openNumberSheet = false,
    this.controller,
    this.labelStyle,
    this.focusNode,
    this.maxLength,
    this.placeholder,
    this.suffixWidth,
    this.height = 40,
    this.fontSize = 14,
    this.keyboardType,
    this.inputFormatters,
    this.onSubmit,
    this.disabled = false,
    this.showError = true,
    this.radius,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.validationIcon,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.showClearButton = false,
    this.locked = false,
    this.showLimit = false,
    this.required = false,
    this.validator,
    this.prefix,
    this.borderSide,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.maxLines = 1,
    this.onChanged,
    this.padding,
    this.minLines,
    this.autofocus = false,
    this.isPassword = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  ConsumerState<MyTextFieldNew> createState() => _MyTextFieldNewState();
}

class _MyTextFieldNewState extends ConsumerState<MyTextFieldNew> {
  String? _errorMsg;
  bool obscureText = false;

  @override
  void initState() {
    if (mounted) {
      if (widget.controller != null) {
        widget.controller!.addListener(() {
          _errorMsg = widget.validator?.call(widget.controller!.text);
          widget.onChanged?.call(widget.controller!.text);
          // setState(() {});
        });
      }
      obscureText = widget.isPassword;
      super.initState();
    }
  }

  @override
  void dispose() {
    // if(mounted) {
    //   widget.controller?.removeListener(() { });
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasError = (widget.validator?.call(widget.controller?.text ?? '') ?? '').isNotEmpty;
    bool requiredError = widget.required && (widget.controller?.text ?? '').isEmpty;
    Color validationColor = widget.validationColor ?? Colors.red;
    bool validationMode = ref.watch(globalFormValidationMode) && widget.required && widget.controller!.text.isEmpty;
    BoxBorder? border = validationMode ? BoxBorder.all(color: Colors.red) : BoxBorder.all(color: Colors.transparent);
    return GestureDetector(
      onTap: !widget.openNumberSheet
          ? null
          : () async {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (c) => NumericInputSheet(
                  label: widget.label ?? '',
                  maxLength: widget.maxLength,
                  onDone: (a) {
                    if (a is String) {
                      widget.controller?.text = a;
                      widget.onSubmit?.call(a);
                      // widget.onChanged.call(a!);
                    }
                  },
                ),
              ).then((a) {
                // if(a is String){
                //   widget.controller?.text = a;
                //   widget.onSubmit?.call(a);
                //   // widget.onChanged.call(a!);
                // }
              });
            },
      child: AbsorbPointer(
        absorbing: widget.openNumberSheet,
        child: ClipRRect(
          borderRadius: widget.radius ?? BorderRadius.circular(5),
          child: widget.labelInRow
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: widget.rowLabelRatio[0],
                      child: widget.label == null
                          ? const SizedBox()
                          : Container(
                              height: widget.height,
                              color: widget.headerBgColor,
                              child: IgnorePointer(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.label ?? '',
                                      style: widget.labelStyle ?? const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: MyColors.black2),
                                    ),
                                    widget.required
                                        ? Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0),
                                            child: const Icon(Icons.star_rate_rounded, color: Colors.red, size: 8),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      flex: widget.rowLabelRatio[1],
                      child: Container(
                        decoration: BoxDecoration(
                          border: border,
                          color: widget.bodyBgColor,
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(widget.radius?.topRight.x ?? 0)),
                        ),

                        // color:Colors.red,
                        height: widget.height,
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: CupertinoTextField(
                                  textInputAction: widget.textInputAction ?? TextInputAction.done,
                                  enabled: !widget.locked && !widget.disabled,
                                  maxLines: obscureText
                                      ? 1
                                      : widget.maxLines == 0
                                      ? null
                                      : widget.maxLines,
                                  minLines: widget.minLines,
                                  maxLength: widget.maxLength,
                                  focusNode: widget.focusNode,
                                  onSubmitted: widget.onSubmit,
                                  keyboardType: widget.keyboardType,
                                  textAlign: widget.textAlign,
                                  obscureText: obscureText,
                                  autofocus: widget.autofocus,
                                  // textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: widget.inputFormatters,
                                  style:
                                      widget.style ??
                                      TextStyle(
                                        fontSize: widget.fontSize,
                                        color: Colors.black,
                                        // height: 0.5
                                        // height: 1,
                                      ),

                                  // textAlignVertical: TextAlignVertical.top,
                                  placeholder: widget.placeholder,
                                  // suffix:
                                  //     widget.suffixIcon ??
                                  //     (!widget.isPassword
                                  //         ? widget.locked
                                  //               ? const Icon(Icons.lock)
                                  //               : null
                                  //         : ExcludeFocus(
                                  //             child: IconButton(
                                  //               onPressed: () {
                                  //                 obscureText = !obscureText;
                                  //                 setState(() {});
                                  //               },
                                  //               icon: Icon(obscureText ? ArtemisIcons.eye : ArtemisIcons.eye_slash),
                                  //             ),
                                  //           )) ??
                                  //     SizedBox(height: 30),
                                  prefix: widget.prefixIcon ?? widget.prefix,

                                  decoration: BoxDecoration(
                                    // border: border,
                                    // borderRadius: widget.radius
                                    // contentPadding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
                                    // filled: false,

                                    // fillColor: widget.bodyBgColor,
                                    // hintText: widget.placeholder,

                                    // counter: widget.showLimit ? null : SizedBox(),
                                    // hintStyle: TextStyle(color: MyColors.black.withOpacity(0.4), fontWeight: FontWeight.w400, fontSize: widget.fontSize),
                                    // border: border,
                                    // enabledBorder: border,
                                    // disabledBorder: border,
                                    // prefixIcon: widget.prefixIcon,
                                    // suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixWidth ?? 200, maxHeight: 40),
                                    //   suffixIcon:
                                    //       widget.suffixIcon ??
                                    //       (!widget.isPassword
                                    //           ? widget.locked
                                    //                 ? const Icon(Icons.lock)
                                    //                 : null
                                    //           : ExcludeFocus(
                                    //               child: IconButton(
                                    //                 onPressed: () {
                                    //                   obscureText = !obscureText;
                                    //                   setState(() {});
                                    //                 },
                                    //                 icon: Icon(obscureText ? ArtemisIcons.eye : ArtemisIcons.eye_slash),
                                    //               ),
                                    //             )) ??
                                    //       SizedBox(height: 30),
                                  ),
                                  controller: widget.controller,
                                ),
                              ),
                              (hasError) && widget.showError
                                  ? Expanded(
                                      child: Container(
                                        height: widget.height,
                                        margin: EdgeInsets.only(left: 12),
                                        padding: EdgeInsets.symmetric(horizontal: 4),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: validationColor),
                                          color: validationColor.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            widget.validationIcon == null ? SizedBox() : Icon(widget.validationIcon!, color: validationColor, size: 20),
                                            Expanded(
                                              child: Text(
                                                "${widget.validator?.call(widget.controller?.text ?? '')}",
                                                style: TextStyle(color: validationColor, fontSize: 9, height: 1),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              widget.showClearButton
                                  ? Padding(
                                      padding: const EdgeInsets.all(.0),
                                      child: DotButton(
                                        flat: true,
                                        color: Colors.black,
                                        onPressed: () {
                                          widget.controller?.clear();
                                          widget.onChanged?.call('');
                                        },
                                        icon: Icons.clear,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.radius,
                    border: border,
                    color: widget.backgroundColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("${widget.label}",style: TextStyle(fontSize: 12),),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoTextField(
                              textInputAction: widget.textInputAction ?? TextInputAction.done,
                              enabled: !widget.locked && !widget.disabled,
                              maxLines: obscureText
                                  ? 1
                                  : widget.maxLines == 0
                                  ? null
                                  : widget.maxLines,
                              minLines: widget.minLines,
                              maxLength: widget.maxLength,
                              focusNode: widget.focusNode,
                              onSubmitted: widget.onSubmit,
                              keyboardType: widget.keyboardType,
                              textAlign: widget.textAlign,
                              obscureText: obscureText,
                              autofocus: widget.autofocus,
                              // textAlignVertical: TextAlignVertical.center,
                              inputFormatters: widget.inputFormatters,
                              style:
                                  widget.style ??
                                  TextStyle(
                                    fontSize: widget.fontSize,
                                    color: Colors.black,
                                    // height: 0.5
                                    // height: 1,
                                  ),
                              placeholder: widget.placeholder,
                              prefix: widget.prefixIcon ?? widget.prefix,

                              decoration: BoxDecoration(
                              ),
                              controller: widget.controller,
                            ),
                          ),
                          (hasError) && widget.showError
                              ? Expanded(
                                  child: Container(
                                    height: (widget.height??40)-12,
                                    margin: EdgeInsets.only(left: 12),
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: validationColor),
                                      color: validationColor.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        widget.validationIcon == null ? SizedBox() : Icon(widget.validationIcon!, color: validationColor, size: 20),
                                        Expanded(
                                          child: Text(
                                            "${widget.validator?.call(widget.controller?.text ?? '')}",
                                            style: TextStyle(color: validationColor, fontSize: 9, height: 1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          widget.showClearButton
                              ? Padding(
                                  padding: const EdgeInsets.all(.0),
                                  child: DotButton(
                                    flat: true,
                                    color: Colors.black,
                                    onPressed: () {
                                      widget.controller?.clear();
                                      widget.onChanged?.call('');
                                    },
                                    icon: Icons.clear,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
