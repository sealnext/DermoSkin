import 'package:dermo/auth/auth_page.dart';
import 'package:dermo/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signOut () {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (FirebaseAuth.instance.currentUser != null)
            IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
            )
        ],
        backgroundColor: Color(0xFF4757E9),
        title: Text(
          'DermoSkin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false, // Prevent the back button from being shown
      ),
      body: SafeArea(
        child: Center(
          child: Text("Sunt logat yeyeyey XD" + user.email!),
        ),
      ),
    );
  }
}
