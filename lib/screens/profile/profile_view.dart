import 'profile_controller.dart';
import 'profile_state.dart';
import 'profile_view_phone.dart';
import 'profile_view_tablet.dart';
import 'profile_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class ProfileView extends ConsumerWidget {
    const ProfileView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return ProfileViewPhone();
      }else if(context.isMyTablet){
        return ProfileViewPhone();
      }else{
        return ProfileViewPhone();
      }
    }
}

