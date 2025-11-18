import 'offline_scanner_controller.dart';
import 'offline_scanner_state.dart';
import 'offline_scanner_view_phone.dart';
import 'offline_scanner_view_tablet.dart';
import 'offline_scanner_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class OfflineScannerView extends ConsumerWidget {
    const OfflineScannerView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return OfflineScannerViewPhone();
      }else if(context.isMyTablet){
        return OfflineScannerViewPhone();
      }else{
        return OfflineScannerViewPhone();
      }
    }
}

