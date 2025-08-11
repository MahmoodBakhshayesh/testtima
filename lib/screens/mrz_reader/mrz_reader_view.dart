import 'mrz_reader_controller.dart';
import 'mrz_reader_state.dart';
import 'mrz_reader_view_phone.dart';
import 'mrz_reader_view_tablet.dart';
import 'mrz_reader_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class MrzReaderView extends ConsumerWidget {
    const MrzReaderView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return MrzReaderViewDesktop();
      }else if(context.isMyTablet){
        return MrzReaderViewTablet();
      }else{
        return MrzReaderViewPhone();
      }
    }
}

