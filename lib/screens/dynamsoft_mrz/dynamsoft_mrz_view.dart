import 'dynamsoft_mrz_controller.dart';
import 'dynamsoft_mrz_state.dart';
import 'dynamsoft_mrz_view_phone.dart';
import 'dynamsoft_mrz_view_tablet.dart';
import 'dynamsoft_mrz_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class DynamsoftMrzView extends ConsumerWidget {
    const DynamsoftMrzView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return DynamsoftMrzViewPhone();
      }else if(context.isMyTablet){
        return DynamsoftMrzViewPhone();
      }else{
        return DynamsoftMrzViewPhone();
      }
    }
}

