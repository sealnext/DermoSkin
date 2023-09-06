import 'package:auto_route/auto_route.dart';
import 'package:dermo/ui/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dermo/core/config/firebase_options.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/core/utility/global_functions.dart';
import 'package:dermo/logic/managers/user_manager.dart';
import 'package:dermo/ui/routes/app_router.dart';
import 'package:dermo/ui/routes/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  await injector.allReady();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final AppRouter _appRouter = AppRouter();
  final UserManager _userManager = injector<UserManager>();

  @override
  void initState() {
    Functions.isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        ref.read(appStatusProvider.notifier).state = AppStatus.firstTime;
        return;
      }
    });

    _userManager.isUSerSignedInStream.listen((isSignedIn) {
      if (isSignedIn) {
        ref.read(appStatusProvider.notifier).state = AppStatus.loggedIn;
      } else {
        ref.read(appStatusProvider.notifier).state = AppStatus.goToLogin;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppStatus appStatus = ref.watch(appStatusProvider);

    if (appStatus == AppStatus.loading) {
      return const CircularProgressIndicator();
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: AutoRouterDelegate.declarative(
        _appRouter,
        routes: (_) => [
          if (appStatus == AppStatus.firstTime)
            const StartRoute()
          else if (appStatus == AppStatus.loggedIn)
            const MainRoute()
          else if (appStatus == AppStatus.goToLogin)
            const LoginRoute()
          else if (appStatus == AppStatus.goToRegister)
            const RegisterRoute()
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
