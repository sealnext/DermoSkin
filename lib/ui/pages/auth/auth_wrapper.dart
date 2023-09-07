import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dermo/ui/pages/auth/login.dart';
import 'package:dermo/ui/pages/auth/register.dart';

@RoutePage(name: "AuthRoute")
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
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
