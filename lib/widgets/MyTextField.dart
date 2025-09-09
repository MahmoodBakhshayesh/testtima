import 'dart:math';
import 'dart:developer' as dev;
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../core/constants/ui.dart';
import '../core/utils_and_services/keyboard/lib/keyboard_actions.dart';
import '../core/utils_and_services/keyboard/lib/keyboard_actions_item.dart';

class MyTextField extends StatefulWidget {
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
  final bool showLimit;
  final bool required;
  final bool disabled;
  final bool labelInRow;
  final bool showError;
  final Color? validationColor;
  final Color? backgroundColor;
  final BorderRadius? radius;
  final double? height;
  final double? suffixWidth;
  final BorderSide? borderSide;
  final List<int> rowLabelRatio;

  const MyTextField({
    Key? key,
    this.label,
    this.nextFn,
    this.rowLabelRatio = const[3,7],
    this.validationColor,
    this.backgroundColor,
    this.prevFn,
    this.labelInRow = false,
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
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
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
    bool hasError = (widget.validator?.call(widget.controller?.text ?? '')?? '' ).isNotEmpty;
    bool requiredError = widget.required && (widget.controller?.text ?? '').isEmpty;
    Color validationColor = widget.validationColor ?? Colors.red;

    if (widget.keyboardType == TextInputType.number) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        widget.label ?? '',
                        style: widget.labelStyle ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.black2),
                      ),
                      const SizedBox(width: 4),
                      widget.required ? const Icon(Icons.star_rate_rounded, color: Colors.red, size: 8) : const SizedBox(),
                    ],
                  ),
                ),
          SizedBox(
            height: widget.height,
            child: Center(
              child: Stack(
                children: [
                  KeyboardActions(
                    autoScroll: false,
                    overscroll: 0,
                    config: _buildConfig(context),
                    child: TextField(
                      textInputAction: TextInputAction.done,
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
                      obscureText: obscureText,
                      autofocus: widget.autofocus,
                      inputFormatters: widget.inputFormatters,
                      style:
                          widget.style ??
                          TextStyle(
                            fontSize: widget.fontSize,
                            // height: 1,
                          ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: widget.placeholder,
                        counter: widget.showLimit ? null : SizedBox(),
                        hintStyle: TextStyle(color: MyColors.notImportant, fontWeight: FontWeight.w400, fontSize: widget.fontSize),
                        border: hasError
                            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                            : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                        focusedBorder: hasError
                            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                            : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                        enabledBorder: hasError
                            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                            : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                        disabledBorder: hasError
                            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                            : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                        prefixIcon: widget.prefixIcon,
                        suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixWidth ?? 200),
                        // suffixIcon: Container(width: 20,height: 20,color: Colors.red,)
                        suffixIcon:
                            widget.suffixIcon ??
                            (!widget.isPassword
                                ? widget.locked
                                      ? const Icon(Icons.lock)
                                      : null
                                : IconButton(
                                    onPressed: () {
                                      obscureText = !obscureText;
                                      setState(() {});
                                    },
                                    icon: Icon(obscureText ? ArtemisIcons.eye : ArtemisIcons.eye_slash),
                                  )),
                      ),
                      controller: widget.controller,
                    ),
                  ),
                  (hasError || requiredError) && widget.showError
                      ? Positioned(
                          bottom: 0.5,
                          right: 4,
                          child: Text(requiredError ? 'Field is required' : "${widget.validator?.call(widget.controller?.text ?? '')}", style: TextStyle(color: Colors.red, fontSize: 9, height: 1)),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      );
    }
    if (widget.labelInRow) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: widget.rowLabelRatio[0],
            child: widget.label == null
                ? const SizedBox()
                : IgnorePointer(
                  child: Row(
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
          Expanded(
            flex: widget.rowLabelRatio[1],
            child: SizedBox(
              height: widget.height,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
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
                        obscureText: obscureText,
                        autofocus: widget.autofocus,
                        inputFormatters: widget.inputFormatters,
                        style:
                            widget.style ??
                            TextStyle(
                              fontSize: widget.fontSize,
                              color: Colors.black
                              // height: 1,
                            ),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
                          filled: true,
                          fillColor: widget.backgroundColor??Colors.white.withOpacity(0.48),
                          hintText: widget.placeholder,
                          prefix: widget.prefix,
                          counter: widget.showLimit ? null : SizedBox(),

                          hintStyle: TextStyle(color: MyColors.black.withOpacity(0.4), fontWeight: FontWeight.w400, fontSize: widget.fontSize),
                          border: hasError && false
                              ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                              : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                          focusedBorder: hasError && false
                              ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                              : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                          enabledBorder: hasError && false
                              ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                              : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                          disabledBorder: hasError && false
                              ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                              : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                          prefixIcon: widget.prefixIcon,
                          suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixWidth ?? 200),
                          // suffixIcon: Container(width: 20,height: 20,color: Colors.red,)
                          suffixIcon:
                              widget.suffixIcon ??
                              (!widget.isPassword
                                  ? widget.locked
                                        ? const Icon(Icons.lock)
                                        : null
                                  : IconButton(
                                      onPressed: () {
                                        obscureText = !obscureText;
                                        setState(() {});
                                      },
                                      icon: Icon(obscureText ? ArtemisIcons.eye : ArtemisIcons.eye_slash),
                                    )),
                        ),
                        controller: widget.controller,
                      ),
                    ),
                    (hasError ) && widget.showError
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
                                  widget.validationIcon == null?SizedBox():Icon(widget.validationIcon!,color: validationColor,size: 20,),
                                  Expanded(child: Text("${widget.validator?.call(widget.controller?.text ?? '')}", style: TextStyle(color: validationColor, fontSize: 9, height: 1),textAlign: TextAlign.center,)),
                                ],
                              ),
                            ),
                        )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      widget.label ?? '',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.black2),
                    ),
                    const SizedBox(width: 4),
                    widget.required ? const Icon(Icons.star_rate_rounded, color: Colors.red, size: 8) : const SizedBox(),
                  ],
                ),
              ),
        SizedBox(
          height: widget.height,
          child: Center(
            child: Stack(
              children: [
                TextField(
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
                  obscureText: obscureText,
                  autofocus: widget.autofocus,
                  inputFormatters: widget.inputFormatters,
                  style:
                      widget.style ??
                      TextStyle(
                        fontSize: widget.fontSize,
                        // height: 1,
                      ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: widget.placeholder,
                    counter: widget.showLimit ? null : SizedBox(),
                    hintStyle: TextStyle(color: MyColors.notImportant, fontWeight: FontWeight.w400, fontSize: widget.fontSize),
                    border: hasError
                        ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                        : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                    focusedBorder: hasError
                        ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                        : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                    enabledBorder: hasError
                        ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                        : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                    disabledBorder: hasError
                        ? OutlineInputBorder(borderSide: BorderSide(color: validationColor))
                        : OutlineInputBorder(borderSide: widget.borderSide ?? BorderSide.none, borderRadius: widget.radius ?? BorderRadius.circular(5)),
                    prefixIcon: widget.prefixIcon,
                    suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixWidth ?? 200),
                    // suffixIcon: Container(width: 20,height: 20,color: Colors.red,)
                    suffixIcon:
                        widget.suffixIcon ??
                        (!widget.isPassword
                            ? widget.locked
                                  ? const Icon(Icons.lock)
                                  : null
                            : IconButton(
                                onPressed: () {
                                  obscureText = !obscureText;
                                  setState(() {});
                                },
                                icon: Icon(obscureText ? ArtemisIcons.eye : ArtemisIcons.eye_slash),
                              )),
                  ),
                  controller: widget.controller,
                ),
                (hasError || requiredError) && widget.showError
                    ? Positioned(
                        bottom: 0.5,
                        right: 4,
                        child: Text(requiredError ? 'Field is required' : "${widget.validator?.call(widget.controller?.text ?? '')}", style: TextStyle(color: validationColor, fontSize: 9, height: 1)),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    FocusNode fn = widget.focusNode ?? FocusNode();
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        // KeyboardActionsItem(
        //   focusNode: fn,
        //   onTapAction: (){
        //     dev.log("pressed");
        //     widget.onSubmit?.call(widget.controller?.text??'');
        //   }
        // ),
        KeyboardActionsItem(
          focusNode: fn,
          displayArrows: false,
          toolbarButtons: [
            (node) {
              return TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.blueAccent, backgroundColor: Colors.transparent, textStyle: TextStyle(fontSize: 14)),
                onPressed: () {
                  node?.unfocus();
                  widget.onSubmit?.call(widget.controller?.text ?? '');
                },
                child: Text("Done"),
              );
            },
          ],
          onTapAction: () {
            dev.log("okokok");
            // widget.onSubmit?.call(widget.controller?.text??'');
          },
        ),
      ],
    );
  }
}

class MyInputFormatter {
  MyInputFormatter._();

  static TextInputFormatter justNumber = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static TextInputFormatter justText = FilteringTextInputFormatter.allow(RegExp(r'[A-z]'));

  static TextInputFormatter numberWithOption = FilteringTextInputFormatter.allow(RegExp(r'^[\d\(\)\-+]+$'));

  // static TextInputFormatter numberFormatter = MaskTextInputFormatter(mask: '###,###,###,###', filter: {"#": RegExp(r'[0-9]')});
  //
  // static TextInputFormatter dateFormatter = MaskTextInputFormatter(mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  static TextInputFormatter uppercase = UpperCaseTextFormatter();
}

TextEditingController tcFromIntValue(int? num, {bool isZeroValid = true}) {
  if (num == null) return TextEditingController();
  if (isZeroValid) {
    TextEditingController tc = TextEditingController.fromValue(
      TextEditingValue(
        text: num == 0 ? "0" : num.toString(),
        selection: TextSelection.fromPosition(TextPosition(offset: num.toString().length)),
      ),
    );
    return tc;
  } else {
    String numS = num == 0 ? "" : "$num";
    TextEditingController tc = TextEditingController.fromValue(
      TextEditingValue(
        text: numS,
        selection: TextSelection.fromPosition(TextPosition(offset: numS.length)),
      ),
    );
    return tc;
  }
}

TextEditingController tcFromStrValue(String val) {
  TextEditingController tc = TextEditingController.fromValue(
    TextEditingValue(
      text: val,
      selection: TextSelection.fromPosition(TextPosition(offset: val.length)),
    ),
  );
  return tc;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

class DateTextFormatter extends TextInputFormatter {
  final DateTime minDate;
  final DateTime maxDate;

  DateTextFormatter({required this.minDate, required this.maxDate});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      // if(newValue.text.length>8) return oldValue;

      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '/');
    return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 3) {
        int? typedYear = int.tryParse(newString.substring(0, 4)) ?? 0;
        int year = max(typedYear, minDate.year);
        year = min(year, maxDate.year);
        newString = "$year";
        newString += seperator;
      }
      if (i == 5) {
        int? typedMonth = int.tryParse(newString.substring(5, 7)) ?? 0;
        // int month = max(typedMonth,minDate.month);
        // month = min(month, maxDate.month);

        int month = max(typedMonth, 1);
        month = min(month, 12);
        newString = "${newString.substring(0, 5)}${month.toString().padLeft(2, '0')}";
        newString += seperator;
      }
      if (i == 7) {
        int? typedDay = int.tryParse(newString.substring(8, 10)) ?? 0;
        // int day = max(typedDay,minDate.day);
        // day = min(day, maxDate.day);
        int day = max(typedDay, 1);
        day = min(day, 31);
        newString = "${newString.substring(0, 7)}$seperator${day.toString().padLeft(2, '0')}";
        // newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
