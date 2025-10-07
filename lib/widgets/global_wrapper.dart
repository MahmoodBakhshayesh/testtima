
import 'dart:developer';

import 'package:abds/initialize.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/classes/server_class.dart';

class GlobalWrapper extends ConsumerWidget {
  final Widget child;

  const GlobalWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    Server selectedServer = ref.watch(selectedServerProvider);
    log(selectedServer.color??'-');
    log(selectedServer.name??'-');
    return Directionality(
      textDirection: TextDirection.ltr,
      child:selectedServer.color == null?child: Material(
        child: Banner(
          shadow: BoxShadow(color:selectedServer.color==null?Colors.transparent: Colors.white),
          color: selectedServer.getColor,
          message: '${selectedServer.name??''} ${getIt<AppDeviceNetworkData>().app.versionKey}',
          textStyle: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: selectedServer.color==null?selectedServer.color=="FFFFFF"?Colors.black:Colors.black:Colors.black),
          location: BannerLocation.topStart,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
