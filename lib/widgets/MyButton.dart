import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../core/extenstions/context_exp.dart';

/// Optional: wrap a subtree so that pressing Enter anywhere inside triggers [onActivate].
/// Useful for dialogs/pages where you want a "default" button.
/// Example:
/// DefaultEnterScope(onActivate: () => _btnKey.currentState?.press(), child: dialog)
class DefaultEnterScope extends StatelessWidget {
  const DefaultEnterScope({super.key, required this.onActivate, required this.child});
  final VoidCallback onActivate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              onActivate();
              return null;
            },
          ),
        },
        child: Focus(autofocus: false, child: child),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final double height;
  final double? width;
  final double? fontSize;
  final double? iconSize;
  final double radius;
  final Callback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final FontWeight? fontWeight;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final Widget? child;
  final String label;
  final bool showLoading;
  final bool fade;
  final bool flat;
  final bool iconInRight;
  final bool disabled;
  final bool reverse;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  /// NEW: when true, pressing Enter/NumpadEnter will trigger the button (when this button or an ancestor has focus)
  final bool listenEnter;

  const MyButton({
    super.key,
    this.height = 40,
    this.fontSize = 13,
    this.iconSize = 18,
    this.radius = 5,
    this.width,
    this.padding,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.textColor,
    this.focusNode,
    this.borderRadius,
    this.borderSide,
    this.autofocus = false,
    this.iconInRight = false,
    this.disabled = false,
    this.statesController,
    this.showLoading = true,
    this.child,
    this.icon,
    required this.label,
    this.fade = false,
    this.flat = false,
    this.reverse = false,
    this.color,
    this.fontWeight,
    this.listenEnter = false, // NEW
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _loading = false;

  /// NEW: allow triggering the button programmatically (e.g., from DefaultEnterScope via GlobalKey)
  void press() => _onTap();

  void _onTap() {
    if (widget.disabled) return;
    if (widget.onPressed is AsyncCallback) {
      if (_loading) return;
      _loading = true;
      setState(() {});
      (widget.onPressed as AsyncCallback).call().whenComplete(() {
        _loading = false;
        if (mounted) setState(() {});
      });
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool disable = widget.disabled || widget.onPressed == null;

    Color c = widget.color ?? context.mainColor;
    Color backgroundColor = (!widget.reverse) ? c : Colors.transparent;
    Color foregroundColor = (widget.reverse) ? c : Colors.white;
    Color? borderColor = widget.borderSide?.color;

    if (widget.reverse) {
      // Swap colors when reverse is true
      Color tmp = c;
      c = foregroundColor;
      foregroundColor = tmp;
    }
    if (widget.fade) {
      backgroundColor = backgroundColor.withOpacity(0.3);
    }
    foregroundColor = widget.textColor ?? foregroundColor;

    if (disable) {
      backgroundColor = const Color(0xffECECEC);
      foregroundColor = Colors.black12;
      borderColor = Colors.black12;
    }

    final button = SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: disable ? null : _onTap,
        onLongPress: widget.onLongPress,
        onFocusChange: widget.onFocusChange,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        statesController: widget.statesController,
        onHover: widget.onHover,
        style: widget.style ??
            ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size.fromHeight(widget.height)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
                  side: (widget.borderSide ?? BorderSide.none).copyWith(color: borderColor),
                ),
              ),
              padding: WidgetStatePropertyAll(widget.padding ?? const EdgeInsets.symmetric(horizontal: 8)),
              shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              backgroundColor: WidgetStatePropertyAll(backgroundColor),
              // Keep your original semantics: when fade=false, don't tint foreground via style; we set text/icon colors directly.
              foregroundColor: WidgetStatePropertyAll(widget.fade ? c : Colors.transparent),
            ),
        child: IndexedStack(
          alignment: Alignment.center,
          index: _loading && widget.showLoading ? 0 : 1,
          children: [
            SpinKitThreeBounce(color: foregroundColor, size: 18),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.iconInRight || widget.icon == null
                      ? const SizedBox()
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(widget.icon, color: foregroundColor, size: widget.iconSize),
                  ),
                  widget.child != null
                      ? Expanded(child: widget.child!)
                      : Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: foregroundColor,
                      fontWeight: widget.fontWeight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  !widget.iconInRight || widget.icon == null
                      ? const SizedBox()
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(widget.icon, color: foregroundColor, size: widget.iconSize),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    if (!widget.listenEnter) {
      return button;
    }

    // Map Enter/NumpadEnter -> ActivateIntent -> _onTap (when this widget or a focused descendant is focused)
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              if (!disable) _onTap();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: widget.autofocus, // ensures focus if you want Enter to work immediately (e.g., in dialogs)
          child: button,
        ),
      ),
    );
  }
}
