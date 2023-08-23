import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/utility/firebase_options.dart';
import 'package:dermo/ui/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/utility/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  await injector.allReady();
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;
  late final Future<PageRouteInfo> _initialRoute;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeRouter();
  }

  Future<void> initializeRouter() async {
    _appRouter = AppRouter();
    _initialRoute = _appRouter.getInitialRoute();
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return FutureBuilder<PageRouteInfo>(
        future: _initialRoute,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return MaterialApp.router(
                routerDelegate: AutoRouterDelegate.declarative(
                  _appRouter,
                  routes: (context) => [snapshot.data!],
                ),
                routeInformationParser: _appRouter.defaultRouteParser(),
              );
            }
            // handle error
          }
          return const CircularProgressIndicator();
        },
      );
    }
    return const CircularProgressIndicator();
  }
}
