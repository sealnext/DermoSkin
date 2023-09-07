import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/core/utility/constants.dart';
import 'package:dermo/ui/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dermo/core/config/firebase_options.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/ui/routes/app_router.dart';
import 'package:dermo/ui/routes/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  await injector.allReady();
  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppStatus appState = ref.watch(appStateProvider);

    return MaterialApp.router(
        theme: ThemeData(
          colorScheme: const ColorScheme(
            surface: Colors.white,
            onSurface: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            onBackground: Colors.black,
            background: ThemeColors.backgroundPrimary,
            primary: ThemeColors.primary,
            secondary: ThemeColors.secondary,
            onPrimary: ThemeColors.white,
            onSecondary: ThemeColors.white,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: AutoRouterDelegate.declarative(
          _appRouter,
          routes: (_) => [
            if (appState == AppStatus.firstTime)
              const StartRoute()
            else if (appState == AppStatus.authentication)
              const AuthRoute()
            else
              const MainRoute()
          ],
        ),
        routeInformationParser: _appRouter.defaultRouteParser());
  }
}
