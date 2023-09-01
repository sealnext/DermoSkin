import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/functions/global_functions.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/logic/managers/user_manager.dart';
import 'package:dermo/ui/pages/home/home.dart';

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
      return const MainRoute();
    }
    return const RegisterRoute();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(path: 'users', page: HomeRoute.page),
          ],
        ),
      ];
}
