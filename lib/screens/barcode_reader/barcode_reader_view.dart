import 'barcode_reader_controller.dart';
import 'barcode_reader_state.dart';
import 'barcode_reader_view_phone.dart';
import 'barcode_reader_view_tablet.dart';
import 'barcode_reader_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class BarcodeReaderView extends ConsumerWidget {
    const BarcodeReaderView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return BarcodeReaderViewDesktop();
      }else if(context.isMyTablet){
        return BarcodeReaderViewTablet();
      }else{
        return BarcodeReaderViewPhone();
      }
    }
}

