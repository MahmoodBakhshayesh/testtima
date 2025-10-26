import 'cupps_controller.dart';
import 'cupps_state.dart';
import 'cupps_view_phone.dart';
import 'cupps_view_tablet.dart';
import 'cupps_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class CuppsView extends ConsumerWidget {
  const CuppsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (context.isDesktop) {
      return CuppsViewDesktop();
    } else if (context.isMyTablet) {
      return CuppsViewPhone();
    } else {
      return CuppsViewPhone();
    }
  }

  // return CuppsViewPhone();
}
