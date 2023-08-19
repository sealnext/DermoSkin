import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../navigator.dart';
import 'start.dart';

class Session extends StatefulWidget {
  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Navigation();
          } else {
            return const StartPage();
          }
        },
      ),
    );
  }
}
