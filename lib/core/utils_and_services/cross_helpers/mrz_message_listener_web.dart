import 'dart:html' as html;
import 'package:get_it/get_it.dart';
import '../../../screens/barcode_reader/barcode_reader_controller.dart';
import '../../../screens/login/login_controller.dart';
import '../../../screens/login/login_state.dart';
import '../../interfaces/failures_int.dart';
import '../cupps_util.dart';
import '../handlers/failure_handler.dart';

final getIt = GetIt.instance;

bool _initializedMrzListener = false;

void initMrzMessageListener() {
  if (_initializedMrzListener) return;
  _initializedMrzListener = true;

  html.window.onMessage.listen((event) {
    try {
      final data = event.data;

      if (data is Map && data['type'] == 'MRZ_DATA') {
        final msg = data['payload'] as String;

        if (getIt<LoginController>().ref.read(userProvider) != null) {
          if (msg.startsWith('M1') ||
              msg.startsWith('M2') ||
              msg.startsWith('M3')) {
            getIt<BarcodeReaderController>()
                .onBarcodeRead(msg, shouldPop: false);
          } else {
            CuppsUtils.ocDataHandlerText(msg);
          }
        }
      }
    } catch (e, st) {
      final errorMsg = 'onMessage error: $e';
      FailureHandler.handle(
        ServerFailure(
          code: -1,
          msg: errorMsg,
          traceMsg: '$errorMsg\n$st',
        ),
      );
    }
  });
}
