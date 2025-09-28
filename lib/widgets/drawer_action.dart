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
  final Color? tileColor;

  const DrawerAction({super.key, required this.title, required this.onTap, required this.leadingIcon, this.dense = false, this.color, this.tileColor});

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


      width: double.infinity,
      child:Material(
        borderRadius: BorderRadius.circular(12),
        color:  (widget.tileColor??Color(0xffABABAB)).withOpacity(0.08),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            border: Border.all(color: (widget.tileColor?.withOpacity(0.35)??Color(0xffF0F0F0)),)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: InkWell(
            // tileColor: Colors.transparent,
            // focusColor: Colors.red,
            onTap: _onTap,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              spacing: 8,
              children: [
                Icon(widget.leadingIcon, size: widget.dense ? 20 : 24, color:widget.tileColor?? c),
                Expanded(
                  child: Text(
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
                ),
                _loading ? SizedBox(width: 40, child: SpinKitThreeBounce(color: c, size: 22)) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
