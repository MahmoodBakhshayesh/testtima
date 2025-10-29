// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class PrimaryActionScope extends StatefulWidget {
//   const PrimaryActionScope({
//     super.key,
//     required this.onSubmit,
//     required this.child,
//     this.enabled = true,
//     this.allowWhenMultilineFocused = false,
//     this.label, // optional: debug label
//   });
//
//   final VoidCallback onSubmit;
//   final Widget child;
//   final bool enabled;
//   final bool allowWhenMultilineFocused;
//   final String? label;
//
//   static bool maybeInvoke(BuildContext context) {
//     final state = context.findAncestorStateOfType<_PrimaryActionScopeState>();
//     return state?._trySubmit() ?? false;
//   }
//
//   @override
//   State<PrimaryActionScope> createState() => _PrimaryActionScopeState();
// }
//
// /// Global keyboard hub.
// class _PrimaryActionHub {
//   _PrimaryActionHub._();
//   static final _PrimaryActionHub instance = _PrimaryActionHub._();
//
//   final List<_PrimaryActionScopeState> _stack = <_PrimaryActionScopeState>[];
//   bool _installed = false;
//   Duration? _lastStamp;
//   PhysicalKeyboardKey? _lastPhysical;
//
//   void register(_PrimaryActionScopeState s) {
//     _stack.remove(s);
//     _stack.add(s);
//     _ensureInstalled();
//   }
//
//   void unregister(_PrimaryActionScopeState s) {
//     _stack.remove(s);
//   }
//
//   void _ensureInstalled() {
//     if (_installed) return;
//     HardwareKeyboard.instance.addHandler(_onKey);
//     _installed = true;
//   }
//
//   bool _onKey(KeyEvent event) {
//     if (event is! KeyDownEvent) return false;
//
//     final key = event.logicalKey;
//     final isEnter = key == LogicalKeyboardKey.enter ||
//         key == LogicalKeyboardKey.numpadEnter;
//     if (!isEnter) return false;
//
//     // De-duplicate repeated events
//     final stamp = event.timeStamp;
//     final pk = event.physicalKey;
//     if (_lastStamp == stamp && _lastPhysical == pk) return true;
//     _lastStamp = stamp;
//     _lastPhysical = pk;
//
//     // Traverse from top-most to bottom
//     for (int i = _stack.length - 1; i >= 0; i--) {
//       final s = _stack[i];
//       if (!s.mounted || !s.widget.enabled) continue;
//       if (!s.isActuallyVisible) continue; // <- skip hidden / offstage scopes
//       if (s._handleGlobalEnter()) return true;
//     }
//     return false;
//   }
// }
//
// class _PrimaryActionScopeState extends State<PrimaryActionScope> {
//   bool get isActuallyVisible {
//     final renderObject = context.findRenderObject();
//     if (renderObject == null || !renderObject.attached) return false;
//     // Estimate visibility: if size is zero or offstage, skip it
//     final box = renderObject is RenderBox ? renderObject : null;
//     if (box != null && (box.size.isEmpty || box.paintBounds.isEmpty)) {
//       return false;
//     }
//
//     // Also skip if widget is Offstage or hidden under Overlay entry not visible
//     final element = context as Element;
//     bool visible = true;
//     element.visitAncestorElements((ancestor) {
//       if (ancestor.widget is Offstage &&
//           (ancestor.widget as Offstage).offstage) {
//         visible = false;
//         return false;
//       }
//       if (ancestor.widget is Visibility &&
//           (ancestor.widget as Visibility).visible == false) {
//         visible = false;
//         return false;
//       }
//       return true;
//     });
//     return visible;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _PrimaryActionHub.instance.register(this);
//   }
//
//   @override
//   void dispose() {
//     _PrimaryActionHub.instance.unregister(this);
//     super.dispose();
//   }
//
//   bool _isMultilineEditorFocused() {
//     final w = FocusManager.instance.primaryFocus?.context?.widget;
//     if (w is EditableText) {
//       final isMultiline =
//           (w.maxLines == null || w.maxLines! > 1) ||
//               w.textInputAction == TextInputAction.newline;
//       return isMultiline;
//     }
//     return false;
//   }
//
//   bool _trySubmit() {
//     if (!widget.enabled) return false;
//     if (!widget.allowWhenMultilineFocused && _isMultilineEditorFocused()) {
//       return false;
//     }
//     widget.onSubmit();
//     return true;
//   }
//
//   bool _handleGlobalEnter() => _trySubmit();
//
//   @override
//   Widget build(BuildContext context) => widget.child;
// }
//
// extension PrimaryActionContext on BuildContext {
//   bool invokePrimaryAction() => PrimaryActionScope.maybeInvoke(this);
// }
