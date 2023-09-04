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
    _userManager.isUSerSignedInStream.listen((isSignedIn) {
      ref.read(isUserSignedInStateProvider.notifier).state = isSignedIn;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasPressedRegisterBtn = ref.watch(registerButtonProvider);
    bool isUserSignedIn = ref.watch(isUserSignedInStateProvider);
    return FutureBuilder<bool>(
      future: Functions.isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            bool isFirstTime = snapshot.data!;
            return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerDelegate: AutoRouterDelegate.declarative(
                  _appRouter,
                  routes: (_) => [
                    if (isFirstTime)
                      const StartRoute()
                    else if (isUserSignedIn)
                      const MainRoute()
                    else if (hasPressedRegisterBtn)
                      const RegisterRoute()
                    else
                      const LoginRoute()
                  ],
                ),
                routeInformationParser: _appRouter.defaultRouteParser());
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
