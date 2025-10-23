import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/time_picker/ui_permission.dart' show UserUiPermission, LogUiPermission, UiPermission, ReportUiPermission;
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/inbox/inbox_state.dart';
import 'package:abds/screens/outbox/outbox_state.dart';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/classes/server_class.dart';
import '../../../initialize.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyButton.dart';
import '../../core/classes/basic_class.dart';
import '../../core/constants/ui.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/time_picker/ui_permission.dart' show UserUiPermission, LogUiPermission, UiPermission;
import '../../core/utils_and_services/version_handler.dart';
import '../../widgets/check_permission.dart';
import '../../widgets/user_avatar.dart';
import '../login/login_controller.dart';
import '../login/login_state.dart';
import 'home_controller.dart';

class HomeDrawer extends ConsumerStatefulWidget {
  const HomeDrawer({super.key});

  @override
  ConsumerState<HomeDrawer> createState() => _LoginLeftDrawerState();
}

class _LoginLeftDrawerState extends ConsumerState<HomeDrawer> {
  static HomeController myHomeController = getIt<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Padding(
        padding: context.getDrawerPadding,
        child: Material(
          color: Colors.white,
          borderRadius: const BorderRadius.horizontal(right: Radius.circular(12), left: Radius.circular(12)),
          elevation: 20,
          child: Container(
            padding: const EdgeInsets.only(top: 12),
            height: MediaQuery.of(context).size.height,
            width:
                width *
                (context.isDesktop
                    ? 0.15
                    : context.isMyTablet
                    ? 0.4
                    : 0.65),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    myHomeController.goNamed(Routes.profile);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
                    child: Row(
                      children: [
                        UserAvatar(url: '', canEdit: true, hasImage: ref.watch(userProvider)?.profile.hasImage ?? false),
                        const SizedBox(width: 8),
                        Expanded(child: Text("${ref.watch(userProvider)?.profile.username ?? ref.watch(userProvider)?.profile.email}")),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        DrawerAction(
                          title: 'Inbox',
                          // permission: LogUiPermission.read(),
                          onTap: () {
                            Navigator.of(context).pop();
                            ref.read(inboxMessagesProvider.notifier).update((s) => []);
                            ref.read(nextMessageId.notifier).update((s) => null);
                            myHomeController.goNamed(Routes.inbox);
                          },
                          leading:  IcomoonLayeredCss.direct_inbox(),
                          trailing: Badge(isLabelVisible: ref.watch(notifCountProvider) > 0, label: Text("${ref.watch(notifCountProvider)}")),
                        ),

                        DrawerAction(
                          title: 'Outbox',
                          // permission: LogUiPermission.read(),
                          onTap: () {
                            Navigator.of(context).pop();
                            ref.read(outboxMessagesProvider.notifier).update((s) => []);
                            ref.read(outboxNextMessageId.notifier).update((s) => null);
                            myHomeController.goNamed(Routes.outbox);
                          },
                          leading:  IcomoonLayeredCss.direct_send(),
                          // trailing: Badge(isLabelVisible: ref.watch(notifCountProvider) > 0, label: Text("${ref.watch(notifCountProvider)}")),
                        ),

                        DrawerAction(
                          title: 'Logs',
                          permission: LogUiPermission.read(),
                          onTap: () {
                            myHomeController.goNamed(Routes.logs);
                          },
                          leadingIcon: Icons.history,
                        ),
                        DrawerAction(
                          title: 'Reports',
                          permission: ReportUiPermission.read(),
                          onTap: () {
                            Navigator.of(context).pop();
                            myHomeController.goNamed(Routes.performance);
                          },
                          leading:  IcomoonLayeredCss.chart_2(),

                        ),
                        DrawerAction(
                          title: 'Search Track ID',
                          // permission: LogUiPermission.read(),
                          onTap: () {
                            Navigator.pop(context);
                            myHomeController.searchTrackId();
                          },
                          leading:  IcomoonLayeredCss.search_normal(),

                        ),
                        CheckPermission(
                          saveSpace: false,
                          permission: UserUiPermission.edit(),
                          otherPermission: [UserUiPermission.add(), UserUiPermission.activeDeactive(), UserUiPermission.delete()],
                          child: DrawerAction(
                            title: 'Users',
                            onTap: () {
                              myHomeController.goNamed(Routes.users);
                            },
                            leading:  IcomoonLayeredCss.profile_2user(),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                DrawerAction(
                  title: 'Sign Out',
                  color: Colors.red,
                  onTap: () {
                    getIt<LoginController>().logout();
                  },
                  leadingIcon: ArtemisIcons.exit,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (c, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data is PackageInfo) {
                              PackageInfo info = (snapshot.data as PackageInfo);

                              String build = VersionHandler.getVersionBuild(info);

                              return Text("V ${info.version} ($build)", style: const TextStyle(color: MyColors.brownGrey7));
                            }
                            return const Text("");
                          },
                        ),
                      ),
                      const Icon(ArtemisIcons.server, color: MyColors.brownGrey7, size: 20),
                      const SizedBox(width: 2),
                      Text(
                        ref.watch(selectedServerProvider)?.title ?? '',
                        style: const TextStyle(color: MyColors.brownGrey7, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerAction extends StatefulWidget {
  final String title;
  final IconData? leadingIcon;
  final Widget? leading;
  final Callback? onTap;
  final bool dense;
  final Color? color;
  final Widget? trailing;
  final UiPermission? permission;

  const DrawerAction({super.key, required this.title, this.leading, required this.onTap, this.leadingIcon, this.dense = false, this.color, this.trailing, this.permission});

  @override
  State<DrawerAction> createState() => _DrawerActionState();
}

class _DrawerActionState extends State<DrawerAction> {
  bool _loading = false;

  _onTap() {
    if (widget.onTap is AsyncCallback) {
      if (_loading) return;
      _loading = true;
      setState(() {});
      (widget.onTap as AsyncCallback).call().whenComplete(() {
        _loading = false;
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      widget.onTap?.call();
    }
  }

  bool validatePermission() {
    final per = BasicClass.validatePermission(widget.permission);
    return per;
  }

  @override
  Widget build(BuildContext context) {
    Color c = widget.color ?? const Color(0xff0A1A3A);
    if (!validatePermission()) return SizedBox();
    return Container(
      // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: MyColors.lineColor))),
      width: double.infinity,
      child: ListTile(
        onTap: _onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.isMyTablet ? 24 : 12,
          vertical: widget.dense
              ? 0
              : context.isMyTablet
              ? 12
              : 0,
        ),
        dense: true,
        leading:widget.leading?? Icon(widget.leadingIcon, size: widget.dense ? 20 : 24, color: c),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w400, color: c, fontSize: widget.dense ? 13 : 16),
              ),
            ),
            _loading ? SizedBox(width: 40, child: SpinKitThreeBounce(color: c, size: 22)) : widget.trailing ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
