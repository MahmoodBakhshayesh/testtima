import 'package:abds/core/extenstions/context_exp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class DrawerAction extends StatefulWidget {
  final String title;
  final IconData leadingIcon;
  final Callback? onTap;
  final bool dense;
  final Color? color;

  const DrawerAction({super.key, required this.title, required this.onTap, required this.leadingIcon, this.dense = false, this.color});

  @override
  State<DrawerAction> createState() => _DrawerActionState();
}

class _DrawerActionState extends State<DrawerAction> {
  bool _loading = false;

  _onTap() {
    if (widget.onTap is AsyncCallback) {
      if (_loading) return;
      _loading = true;
      setState(() {});
      (widget.onTap as AsyncCallback).call().whenComplete(() {
        _loading = false;
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color c = widget.color ?? const Color(0xff0A1A3A);
    return Container(
      // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: MyColors.lineColor))),
      width: double.infinity,
      child: ListTile(
        onTap: _onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.isMyTablet ? 16 : 12,
          vertical: widget.dense
              ? context.isMyTablet
                    ? 4
                    : 0
              : context.isMyTablet
              ? 12
              : 0,
        ),
        dense: true,
        leading: Icon(widget.leadingIcon, size: widget.dense ? 20 : 24, color: c),
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: c,
            fontSize: context.isMyTablet
                ? 16
                : widget.dense
                ? 13
                : 16,
          ),
        ),
        trailing: _loading ? SizedBox(width: 40, child: SpinKitThreeBounce(color: c, size: 22)) : const SizedBox(),
      ),
    );
  }
}
