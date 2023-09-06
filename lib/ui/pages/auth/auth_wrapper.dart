import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dermo/ui/pages/auth/login.dart';
import 'package:dermo/ui/pages/auth/register.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(name: "AuthRoute")
class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(toggleRegisterPage: togglePage);
    }
    return RegisterPage(toggleLoginPage: togglePage);
  }
}
