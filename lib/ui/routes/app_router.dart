import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, initial: true),
        AutoRoute(page: AuthRoute.page),
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
