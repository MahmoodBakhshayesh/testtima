import 'message_details_controller.dart';
import 'message_details_state.dart';
import 'message_details_view_phone.dart';
import 'message_details_view_tablet.dart';
import 'message_details_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class MessageDetailsView extends ConsumerWidget {
    const MessageDetailsView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return MessageDetailsViewDesktop();
      }else if(context.isMyTablet){
        return MessageDetailsViewTablet();
      }else{
        return MessageDetailsViewPhone();
      }
    }
}

