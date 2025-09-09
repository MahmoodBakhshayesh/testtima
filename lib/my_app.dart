import 'package:abds/screens/add_user/add_user_view.dart';
import 'package:abds/screens/barcode_reader/barcode_reader_view.dart';
import 'package:abds/screens/dynamsoft_mrz/dynamsoft_mrz_view.dart';
import 'package:abds/screens/logs/logs_view.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_view.dart';
import 'package:abds/screens/users/users_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/screens/home/home_view.dart';
import '/screens/login/login_view.dart';
import 'package:tree_navigation/tree_navigation.dart';
import 'core/constants/ui.dart';
import 'core/navigation/routes.dart';
import 'initialize.dart';
import 'screens/performance/performance_view.dart';
import 'screens/profile/profile_view.dart';


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    getIt.registerSingleton(ref);
    initNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final router = ref.watch(routerProvider);
    return TreeNavigation.makeMaterialApp(
      theme: MyTheme.lightAbomis(context),
      debugLogDiagnostics: true,
      routeInfoList: Routes.allRoutes,
      routes: [
        TreeRoute(routeInfo: Routes.login, pageWidget: LoginView()),
        TreeRoute(routeInfo: Routes.users, pageWidget: UsersView()),
        TreeRoute(routeInfo: Routes.logs, pageWidget: LogsView()),
        TreeRoute(routeInfo: Routes.addUser, pageWidget: AddUserView()),
        TreeRoute(routeInfo: Routes.profile, pageWidget: ProfileView()),
        TreeRoute(routeInfo: Routes.performance, pageWidget: PerformanceView()),
        TreeRoute(
          routeInfo: Routes.home,
          pageWidget: HomeView(),
          routes: [
            TreeRoute(routeInfo: Routes.mrzReader, pageWidget: MrzReaderView(),routes: [
              TreeRoute(routeInfo: Routes.dynamsoft, pageWidget: DynamsoftMrzView()),
            ]),
            TreeRoute(routeInfo: Routes.barcodeReader, pageWidget: BarcodeReaderView()),
          ],
        ),
      ],
      navigatorKey: topKey,
      observers: [BotToastNavigatorObserver()],
      globalKeyList: [topKey, shellKey],
    );
  }
}
