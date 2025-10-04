import 'dart:async';
import 'package:abds/widgets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ---------- USAGE EXAMPLE ----------
/// Put this inside your page to use the custom numeric keyboard.
/// The TextField is readOnly and updates via the keypad.
class NumericKeyboardDemoPage extends StatefulWidget {
  const NumericKeyboardDemoPage({super.key});

  @override
  State<NumericKeyboardDemoPage> createState() => _NumericKeyboardDemoPageState();
}

class _NumericKeyboardDemoPageState extends State<NumericKeyboardDemoPage> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _openKeyboard() async {
    // Prevent system keyboard and open our modal keypad
    _focus.unfocus();
    await showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) {
        return CupertinoNumericKeyboard(
          controller: _ctrl,
          onDone: () => Navigator.of(context).pop(),
          // Optional:
          // maxLength: 10,
          // allowLeadingZeros: true,
          // enableHaptics: true,
          // allowDecimal: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Numeric Keyboard Demo')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Amount', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: _ctrl,
                focusNode: _focus,
                readOnly: true, // disables system keyboard
                placeholder: 'Tap to enter',
                onTap: _openKeyboard,
                textAlign: TextAlign.center,
                showCursor: true,
                style: const TextStyle(fontSize: 28, fontFeatures: [FontFeature.tabularFigures()]),
                suffix: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Icon(CupertinoIcons.number),
                  onPressed: _openKeyboard,
                ),
              ),
              const Spacer(),
              CupertinoButton.filled(
                child: const Text('Submit'),
                onPressed: () {
                  // Use _ctrl.text here
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const Text('Value'),
                      content: Text(_ctrl.text.isEmpty ? '—' : _ctrl.text),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------- WIDGET: CupertinoNumericKeyboard ----------
/// iOS-styled numeric keyboard with Delete & Done.
class CupertinoNumericKeyboard extends StatefulWidget {
  const CupertinoNumericKeyboard({
    super.key,
    required this.controller,
    this.onDone,
    this.maxLength,
    this.allowLeadingZeros = true,
    this.allowDecimal = false,
    this.enableHaptics = true,
  });

  final TextEditingController controller;
  final VoidCallback? onDone;
  final int? maxLength;
  final bool allowLeadingZeros;
  final bool allowDecimal;
  final bool enableHaptics;

  @override
  State<CupertinoNumericKeyboard> createState() => _CupertinoNumericKeyboardState();
}

class _CupertinoNumericKeyboardState extends State<CupertinoNumericKeyboard> {
  Timer? _repeatTimer;

  void _haptic() {
    if (widget.enableHaptics) HapticFeedback.lightImpact();
  }

  void _insert(String ch) {
    final text = widget.controller.text;
    if (widget.maxLength != null && text.length >= widget.maxLength!) return;

    // prevent leading zeros if disallowed (except when decimal typing)
    if (!widget.allowLeadingZeros && text.isEmpty && ch == '0') return;

    final sel = widget.controller.selection;
    final int base = sel.isValid ? sel.start : text.length;
    final int extent = sel.isValid ? sel.end : text.length;
    final newText = text.replaceRange(base, extent, ch);
    widget.controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: base + ch.length),
    );
    _haptic();
  }

  void _maybeInsertDecimal() {
    if (!widget.allowDecimal) return;
    final t = widget.controller.text;
    if (t.contains('.')) return;
    if (t.isEmpty) {
      // start with "0."
      _insert('0.');
    } else {
      _insert('.');
    }
  }

  void _deleteOne() {
    final text = widget.controller.text;
    final sel = widget.controller.selection;

    if (sel.isValid && sel.start != sel.end) {
      // Delete selection
      final newText = text.replaceRange(sel.start, sel.end, '');
      widget.controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: sel.start),
      );
      _haptic();
      return;
    }

    final cursor = sel.isValid ? sel.start : text.length;
    if (cursor == 0) return;
    final newText = text.replaceRange(cursor - 1, cursor, '');
    widget.controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursor - 1),
    );
    _haptic();
  }

  void _startRepeatDelete() {
    _repeatTimer?.cancel();
    _repeatTimer = Timer.periodic(const Duration(milliseconds: 60), (_) => _deleteOne());
  }

  void _stopRepeatDelete() {
    _repeatTimer?.cancel();
    _repeatTimer = null;
  }

  @override
  void dispose() {
    _stopRepeatDelete();
    super.dispose();
  }

  /// --- REPLACE build() of CupertinoNumericKeyboard with this ---
  @override
  Widget build(BuildContext context) {
    final bg = CupertinoTheme.of(context).barBackgroundColor;
    final isDark = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.5 : 0.1),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
          child: _KeyGrid(
            onNumber: _insert,
            onDecimal: _maybeInsertDecimal,
            onDeleteTap: _deleteOne,
            onDeleteLongPressStart: _startRepeatDelete,
            onDeleteLongPressEnd: _stopRepeatDelete,
            onDone: widget.onDone,
            allowDecimal: widget.allowDecimal,
          ),
        ),
      ),
    );
  }

}

/// --- REPLACE _KeyGrid with this version (adds Done bottom-right) ---
class _KeyGrid extends StatelessWidget {
  const _KeyGrid({
    required this.onNumber,
    required this.onDecimal,
    required this.onDeleteTap,
    required this.onDeleteLongPressStart,
    required this.onDeleteLongPressEnd,
    required this.onDone,
    required this.allowDecimal,
  });

  final void Function(String) onNumber;
  final VoidCallback onDecimal;
  final VoidCallback onDeleteTap;
  final VoidCallback onDeleteLongPressStart;
  final VoidCallback onDeleteLongPressEnd;
  final VoidCallback? onDone;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    const keys = ['1','2','3','4','5','6','7','8','9'];

    Widget buildKey(Widget child,
        {VoidCallback? onTap, VoidCallback? onLongPressStart, VoidCallback? onLongPressEnd}) {
      return _CupertinoKey(
        onTap: onTap,
        onLongPressStart: onLongPressStart,
        onLongPressEnd: onLongPressEnd,
        child: child,
      );
    }

    Widget buildDoneKey() {
      // iOS-like filled action key
      return MyButton(label: "Done",onPressed: onDone,radius: 12,fontSize: 20,fontWeight: FontWeight.w700,height: 56,);
      return GestureDetector(
        onTap: onDone,
        child: Container(
          height: 56,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            color:onDone==null?CupertinoColors.inactiveGray: CupertinoColors.activeBlue.resolveFrom(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const DefaultTextStyle(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: CupertinoColors.white,
              letterSpacing: 0.3,
            ),
            child: Text('Done'),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var row = 0; row < 3; row++)
          Row(
            children: [
              for (var col = 0; col < 3; col++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: buildKey(
                      Center(child: Text(keys[row * 3 + col], style: const TextStyle(fontSize: 28))),
                      onTap: () => onNumber(keys[row * 3 + col]),
                    ),
                  ),
                ),
            ],
          ),
        Row(
          children: [
            // Left bottom: Decimal OR Delete
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: allowDecimal
                    ? buildKey(
                  const Center(child: Text('.', style: TextStyle(fontSize: 32, height: 1))),
                  onTap: onDecimal,
                )
                    : buildKey(
                  const Center(child: Icon(CupertinoIcons.delete_left, size: 26)),
                  onTap: onDeleteTap,
                  onLongPressStart: onDeleteLongPressStart,
                  onLongPressEnd: onDeleteLongPressEnd,
                ),
              ),
            ),
            // Middle: 0
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: buildKey(
                  const Center(child: Text('0', style: TextStyle(fontSize: 28))),
                  onTap: () => onNumber('0'),
                ),
              ),
            ),
            // Right bottom: DONE
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: buildDoneKey(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class _CupertinoKey extends StatefulWidget {
  const _CupertinoKey({
    required this.child,
    this.onTap,
    this.onLongPressStart,
    this.onLongPressEnd,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPressStart;
  final VoidCallback? onLongPressEnd;

  @override
  State<_CupertinoKey> createState() => _CupertinoKeyState();
}

class _CupertinoKeyState extends State<_CupertinoKey> {
  bool _pressed = false;

  void _haptic() => HapticFeedback.selectionClick();

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    final fill = CupertinoColors.systemGrey5.resolveFrom(context);
    final pressedFill = CupertinoColors.systemGrey4.resolveFrom(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        setState(() => _pressed = true);
        _haptic();
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      onLongPressStart: widget.onLongPressStart != null
          ? (_) {
        setState(() => _pressed = true);
        _haptic();
        widget.onLongPressStart?.call();
      }
          : null,
      onLongPressEnd: widget.onLongPressEnd != null
          ? (_) {
        setState(() => _pressed = false);
        widget.onLongPressEnd?.call();
      }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        curve: Curves.easeOut,
        height: 56,
        decoration: BoxDecoration(
          color: _pressed ? pressedFill : fill,
          borderRadius: radius,
        ),
        child: DefaultTextStyle.merge(
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
