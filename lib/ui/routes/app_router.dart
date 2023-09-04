import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/utility/global_functions.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  Future<PageRouteInfo> getInitialRoute() async {
    bool isFirsTime = await Functions.isFirstTime();
    if (isFirsTime) {
      return const StartRoute();
    }
    return const RegisterRoute();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: AppointmentRoute.page),
            AutoRoute(page: CameraRoute.page),
            AutoRoute(page: RoomsRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
      ];
}
