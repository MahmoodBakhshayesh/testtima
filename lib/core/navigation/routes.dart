
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../screens/home/home_view_desktop.dart';
import '../../screens/home/home_view_phone.dart';
import '../../screens/home/home_view_tablet.dart';
import '../../screens/login/login_view_desktop.dart';
import '../../screens/login/login_view_phone.dart';
import '../../screens/login/login_view_tablet.dart';
import '../../core/extenstions/context_exp.dart';

GlobalKey<NavigatorState> topKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> shellKey = GlobalKey<NavigatorState>();


class MyRouteInfo extends RouteInfo {
  MyRouteInfo({
    required super.path,
    required super.name,
    required super.isShellRoute,
  });

}


abstract class Routes {
  static MyRouteInfo login = MyRouteInfo(
    path: '/',
    name: 'login',
    isShellRoute: false,
  );
  static MyRouteInfo home = MyRouteInfo(
    path: '/home',
    name: 'home',
    isShellRoute: false,
  );
  static MyRouteInfo mrzReader = MyRouteInfo(
    path: 'mrzReader',
    name: 'mrzReader',
    isShellRoute: false,
  );
  static MyRouteInfo barcodeReader = MyRouteInfo(
    path: 'barcodeReader',
    name: 'barcodeReader',
    isShellRoute: false,
  );
  static MyRouteInfo users = MyRouteInfo(
    path: '/users',
    name: 'users',
    isShellRoute: false,
  );
  static MyRouteInfo addUser = MyRouteInfo(
    path: '/addUser',
    name: 'addUser',
    isShellRoute: false,
  );
  static MyRouteInfo logs = MyRouteInfo(
    path: '/logs',
    name: 'logs',
    isShellRoute: false,
  );
  static MyRouteInfo profile = MyRouteInfo(
    path: '/profile',
    name: 'profile',
    isShellRoute: false,
  );
  static MyRouteInfo menuSetting = MyRouteInfo(
    path: '/menuSetting',
    name: 'menuSetting',
    isShellRoute: false,
  );
  static MyRouteInfo resultReport = MyRouteInfo(

    path: 'resultReport',
    name: 'resultReport',
    isShellRoute: false,
  );
  static MyRouteInfo dynamsoft = MyRouteInfo(
    path: 'dynamsoft',
    name: 'dynamsoft',
    isShellRoute: false,
  );
  static MyRouteInfo performance = MyRouteInfo(
    path: '/performance',
    name: 'performance',
    isShellRoute: false,
  );
  static MyRouteInfo cupps = MyRouteInfo(
    path: '/cupps',
    name: 'cupps',
    isShellRoute: false,
  );
  static MyRouteInfo inbox = MyRouteInfo(
    path: '/inbox',
    name: 'inbox',
    isShellRoute: false,
  );
  static MyRouteInfo outbox = MyRouteInfo(
    path: '/outbox',
    name: 'outbox',
    isShellRoute: false,
  );
  static MyRouteInfo messageDetails = MyRouteInfo(
    path: 'messageDetails',
    name: 'messageDetails',
    isShellRoute: false,
  );

  static List<RouteInfo> allRoutes = [
    login,
    home,
    barcodeReader,
    mrzReader,
    logs,
    profile,
    inbox,
    outbox,
    messageDetails,
  ];
}
