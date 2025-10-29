// top_route_tracker.dart
import 'dart:developer';

import 'package:abds/core/utils_and_services/button_keys.dart';
import 'package:abds/screens/login/login_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../initialize.dart';

class TopRouteTracker extends NavigatorObserver {
  Route<dynamic>? _current;

  Route<dynamic>? get currentRoute => _current;

  @override
  void didPush(Route route, Route? previousRoute) {
    _current = route;
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _current = newRoute ?? _current;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _current = previousRoute ?? _current;
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // Keep current as-is unless removed route was current
    if (_current == route) _current = previousRoute;
    super.didRemove(route, previousRoute);
  }
}


typedef EnterHandler = bool Function(Route<dynamic>? topRoute);

class GlobalEnter {
  GlobalEnter._();
  static final GlobalEnter _inst = GlobalEnter._();
  static GlobalEnter get I => _inst;

  final List<EnterHandler> _tempStack = <EnterHandler>[]; // dialogs/sheets
  final Map<String, EnterHandler> _routeHandlers = <String, EnterHandler>{};
  TopRouteTracker? _tracker;
  bool _installed = false;

  // For dedupe
  Duration? _lastStamp;
  PhysicalKeyboardKey? _lastPhysical;

  void init({required TopRouteTracker tracker}) {
    _tracker = tracker;
    if (_installed) return;
    HardwareKeyboard.instance.addHandler(_onKey);
    _installed = true;
  }

  /// Attach a handler for a route name (e.g. '/login', '/home').
  void registerRouteHandler(String routeName, EnterHandler handler) {
    _routeHandlers[routeName] = handler;
  }

  void unregisterRouteHandler(String routeName) {
    _routeHandlers.remove(routeName);
  }

  /// Push a temporary handler (e.g. while a dialog is open). Last pushed wins.
  VoidCallback pushTemp(EnterHandler handler) {
    _tempStack.add(handler);
    return () {
      _tempStack.remove(handler);
    };
  }

  bool _onKey(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    final lk = event.logicalKey;
    final isEnter = lk == LogicalKeyboardKey.enter ||
        lk == LogicalKeyboardKey.numpadEnter;
    if (!isEnter) return false;

    // De-duplicate repeated events
    final stamp = event.timeStamp;
    final pk = event.physicalKey;
    if (_lastStamp == stamp && _lastPhysical == pk) {
      return true; // already handled
    }
    _lastStamp = stamp;
    _lastPhysical = pk;

    // 1) Temp handlers (dialogs/sheets) — LIFO
    for (int i = _tempStack.length - 1; i >= 0; i--) {
      final handled = _tempStack[i](_tracker?.currentRoute);
      if (handled) return true;
    }

    // 2) Route-level handler
    final top = _tracker?.currentRoute;
    final name = top?.settings.name;
    if (name != null) {
      final h = _routeHandlers[name];
      if (h != null && h(top)) return true;
    }
    if(name == "login"){
      ButtonKeys.loginButtonKey.currentState?.triggerTap();
    }else if(name!.startsWith("homeConfirmScannedDocDialog")){
      ButtonKeys.confirmDocKey.currentState?.triggerTap();

    }

    log("onKey ${event.physicalKey.debugName} on $name");

    return false;
  }
}

