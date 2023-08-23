import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/functions/global_functions.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/logic/managers/user_manager.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final _userManager = injector<UserManager>();

  Future<PageRouteInfo> getInitialRoute() async {
    bool isFirsTime = await Functions.isFirstTime();
    if (isFirsTime) {
      return const StartRoute();
    }
    if (_userManager.isUSerSignedIn()) {
      return const HomeRoute();
    }
    return const LoginRoute();
  }

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: StartRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: LoginRoute.page),
  ];
}