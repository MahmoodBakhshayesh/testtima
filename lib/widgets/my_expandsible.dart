// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:flutter/material.dart';
library;

import 'package:flutter/material.dart';


/// The type of the callback that returns the header or body of an [MyExpansible].
///
/// The `animation` property exposes the underlying expanding or collapsing
/// animation, which has a value of 0 when the [MyExpansible] is completely
/// collapsed and 1 when it is completely expanded. This can be used to drive
/// animations that sync up with the expanding or collapsing animation, such as
/// rotating an icon.
///
/// See also:
///
///   * [MyExpansible.headerBuilder], which is of this type.
///   * [MyExpansible.bodyBuilder], which is also of this type.
typedef ExpansibleComponentBuilder =
Widget Function(BuildContext context, Animation<double> animation);

/// The type of the callback that uses the header and body of an [MyExpansible]
/// widget to build the widget.
///
/// The `header` property is the header returned by [MyExpansible.headerBuilder].
/// The `body` property is the body returned by [MyExpansible.bodyBuilder] wrapped
/// in an [Offstage] to hide the body when the [MyExpansible] is collapsed.
///
/// The `animation` property exposes the underlying expanding or collapsing
/// animation, which has a value of 0 when the [MyExpansible] is completely
/// collapsed and 1 when it is completely expanded. This can be used to drive
/// animations that sync up with the expanding or collapsing animation, such as
/// rotating an icon.
///
/// See also:
///
///   * [MyExpansible.expansibleBuilder], which is of this type.
typedef ExpansibleBuilder =
Widget Function(BuildContext context, Widget header, Widget body, Animation<double> animation);

/// A controller for managing the expansion state of an [MyExpansible].
///
/// This class is a [ChangeNotifier] that notifies its listeners if the value of
/// [isExpanded] changes.
///
/// This controller provides methods to programmatically expand or collapse the
/// widget, and it allows external components to query the current expansion
/// state.
///
/// The controller's [expand] and [collapse] methods cause the
/// the [MyExpansible] to rebuild, so they may not be called from
/// a build method.
///
/// Remember to [dispose] of the [ExpansibleController] when it is no longer
/// needed. This will ensure we discard any resources used by the object.

/// A [StatefulWidget] that expands and collapses.
///
///
/// An [MyExpansible] consists of a header, which is always shown, and a
/// body, which is hidden in its collapsed state and shown in its expanded
/// state.
///
/// The [MyExpansible] is expanded or collapsed with an animation driven by an
/// [AnimationController]. When the widget is expanded, the height of its body
/// animates from 0 to its fully expanded height.
///
/// This widget is typically used with [ListView] to create an "expand /
/// collapse" list entry. When used with scrolling widgets like [ListView], a
/// unique [PageStorageKey] must be specified as the [key], to enable the
/// [MyExpansible] to save and restore its expanded state when it is scrolled
/// in and out of view.
///
/// Provide [headerBuilder] and [bodyBuilder] callbacks to
/// build the header and body widgets. An additional [expansibleBuilder]
/// callback can be provided to further customize the layout of the widget.
///
/// The [MyExpansible] does not inherently toggle the expansion state. To toggle
/// the expansion state, call [ExpansibleController.expand] and
/// [ExpansibleController.collapse] as needed, most typically when the header
/// returned in [headerBuilder] is tapped.
///
/// See also:
///
///  * [ExpansionTile], a Material-styled widget that expands and collapses.
class MyExpansible extends StatefulWidget {
  /// Creates an instance of [MyExpansible].
  const MyExpansible({
    super.key,
    required this.headerBuilder,
    required this.bodyBuilder,
    required this.footerBuilder,
    required this.controller,
    this.expansibleBuilder = _defaultExpansibleBuilder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.ease,
    this.reverseCurve,
    this.maintainState = true,
  });

  /// Expands and collapses the widget.
  ///
  /// The controller manages the expansion state and toggles the expansion.
  final ExpansibleController controller;

  /// Builds the always-displayed header.
  ///
  /// Many use cases involve toggling the expansion state when this header is
  /// tapped. To toggle the expansion state, call [ExpansibleController.expand]
  /// or [ExpansibleController.collapse].
  final ExpansibleComponentBuilder headerBuilder;

  /// Builds the collapsible body.
  ///
  /// When this widget is expanded, the height of its body animates from 0 to
  /// its fully extended height.
  final ExpansibleComponentBuilder bodyBuilder;
  final ExpansibleComponentBuilder footerBuilder;

  /// The duration of the expansion animation.
  ///
  /// Defaults to a duration of 200ms.
  final Duration duration;

  /// The curve of the expansion animation.
  ///
  /// Defaults to [Curves.ease].
  final Curve curve;

  /// The reverse curve of the expansion animation.
  ///
  /// If null, uses [curve] in both directions.
  final Curve? reverseCurve;

  /// Whether the state of the body is maintained when the widget expands or
  /// collapses.
  ///
  /// If true, the body is kept in the tree while the widget is
  /// collapsed. Otherwise, the body is removed from the tree when the
  /// widget is collapsed and recreated upon expansion.
  ///
  /// Defaults to false.
  final bool maintainState;

  /// Builds the widget with the results of [headerBuilder] and [bodyBuilder].
  ///
  /// Defaults to placing the header and body in a [Column].
  final ExpansibleBuilder expansibleBuilder;

  static Widget _defaultExpansibleBuilder(
      BuildContext context,
      Widget header,
      Widget body,
      Animation<double> animation,
      ) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[header, body]);
  }

  @override
  State<StatefulWidget> createState() => _MyExpansibleState();
}

class _MyExpansibleState extends State<MyExpansible> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _heightFactor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.duration, vsync: this);
    final bool initiallyExpanded =
        PageStorage.maybeOf(context)?.readState(context) as bool? ?? widget.controller.isExpanded;
    if (initiallyExpanded) {
      _animationController.value = 1.0;
      widget.controller.expand();
    } else {
      widget.controller.collapse();
    }
    final Tween<double> heightFactorTween = Tween<double>(begin: 0.0, end: 1.0);
    _heightFactor = CurvedAnimation(
      parent: _animationController.drive(heightFactorTween),
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );
    widget.controller.addListener(_toggleExpansion);
  }

  @override
  void didUpdateWidget(covariant MyExpansible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) {
      _heightFactor.curve = widget.curve;
    }
    if (widget.reverseCurve != oldWidget.reverseCurve) {
      _heightFactor.reverseCurve = widget.reverseCurve;
    }
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_toggleExpansion);
      widget.controller.addListener(_toggleExpansion);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_toggleExpansion);
    _animationController.dispose();
    _heightFactor.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      // Rebuild with the header and the animating body.
      if (widget.controller.isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without the body.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, widget.controller.isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(!_animationController.isDismissed || !widget.controller.isExpanded);
    final bool closed = !widget.controller.isExpanded && _animationController.isDismissed;
    final bool shouldRemoveBody = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(enabled: !closed, child: Column(children: [
        widget.bodyBuilder(context, _animationController),
      ],)),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (BuildContext context, Widget? child) {
        final Widget header = widget.headerBuilder(context, _animationController);
        final Widget body = ClipRect(child: Align(heightFactor: _heightFactor.value, child: child));
        return Column(
          children: [
            widget.expansibleBuilder(context, header, body, _animationController),
            widget.footerBuilder(context, _animationController),
          ],
        );
      },
      child: shouldRemoveBody ? null : result,
    );
  }
}
