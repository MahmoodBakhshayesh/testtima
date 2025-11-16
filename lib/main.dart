import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tree_navigation/tree_navigation.dart';

import 'core/constants/apis.dart';
import 'core/constants/assest.dart';
import 'core/constants/ui.dart';
// import 'core/util/app_config.dart';
import 'core/interfaces/failures_int.dart';
import 'core/utils_and_services/handlers/failure_handler.dart';
import 'core/utils_and_services/timatic/src/errors.dart';
import 'initialize.dart';
import 'my_app.dart';

void main() async {
  // AppConfig(
  //     flavor: Flavor.abomis,
  //     baseUrl: Apis.baseUrl,
  //     lightTheme: MyTheme.lightAbomis,
  //     darkTheme: MyTheme.lightAbomis,
  //     logoAddress: AssetImages.logo
  // );
  await init();

  // FlutterError.onError = (FlutterErrorDetails details) {
  //   Zone.current.handleUncaughtError(details.exception, details.stack??StackTrace.fromString("-"));
  // };
  //
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   _handleError(error, stack);
  //   return true; // handled
  // };

  runApp(  ProviderScope(child: RouteProvider(child: MyApp())));

  // runZonedGuarded(() {
  //   runApp(  ProviderScope(child: RouteProvider(child: MyApp())));
  // }, (error, stack) {
  //   _handleError(error, stack);
  // });

  // runApp( const ProviderScope(child: MyApp()));
}

void _handleError(Object error, StackTrace stack) {
  // Central place to log, send to crash reporting, etc.
  log('Caught error: $error');
  log('Stack trace: $stack');

  if(error is TimaticError){
    ServerFailure failure = ServerFailure(code: error.statusCode??0, msg: error.message, traceMsg: error.message);
    if(error.cause is Error){
      log((error.cause as Error).stackTrace.toString());
    }
    FailureHandler.handle(failure);
  }else if (error is TimaticParsingError){
    ServerFailure failure = ServerFailure(code: error.statusCode??0, msg: error.message, traceMsg: error.message);
    if(error.cause is Error){
      log((error.cause as Error).stackTrace.toString());
    }
    FailureHandler.handle(failure);
  }else if (error is TimaticNetworkError){
    ServerFailure failure = ServerFailure(code: error.statusCode??0, msg: error.message, traceMsg: error.message);
    if(error.cause is Error){
      log((error.cause as Error).stackTrace.toString());
    }
    FailureHandler.handle(failure);

  }

  // Example: Send to Sentry, Firebase Crashlytics, etc.
  // Sentry.captureException(error, stackTrace: stack);
}