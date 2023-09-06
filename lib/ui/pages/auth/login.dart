import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:dermo/logic/use_cases/sign_in_use_case.dart';
import 'package:dermo/old/logic/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  final void Function() toggleRegisterPage;

  const LoginPage({super.key, required this.toggleRegisterPage});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _signIn = injector<SignInUseCase>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      var email = Email(_emailController.text);
      var password = Password(_passwordController.text);
      await _signIn(email: email, password: password);
    } catch (e) {
      debugPrint("$e");
    }
  }

  void signWithGoogle() async {
    await AuthService.signInWithGoogle();
  }

  void signInWithApple() async {
    await AuthService.signInWhithApple();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4757E9),
        title: const Text(
          'DermoSkin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading:
            false, // Prevent the back button from being shown
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icon logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                    color: Color(0xFF4757E9),
                  ),
                  const SizedBox(height: 50),
                  const Text("Welcome back, you've been missed!"),
                  const SizedBox(
                    height: 30,
                  ),
                  //email
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF4757E9), // Set the background color here
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Set the border radius
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member?"),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.toggleRegisterPage,
                        child: const Text(
                          "Register now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 2, // Adjust the height as needed
                          color: Colors.grey,
                          width: 145,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Or",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 2, // Adjust the height as needed
                          color: Colors.grey,
                          width: 145,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      signWithGoogle();
                    },
                    icon: Image.asset(
                      'assets/images/google.png', // Replace with your actual asset path
                      width: 30, // Set the width of the logo as needed
                      height: 30, // Set the height of the logo as needed
                    ),
                    label: const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[200],
                      minimumSize: const Size(400, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                            color: Colors.black), // Black border
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Platform.isIOS
                      ? (ElevatedButton.icon(
                          onPressed: () {
                            signInWithApple();
                          },
                          icon: const Icon(Icons.apple),
                          label: const Text(
                            'Sign in with Apple',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            minimumSize: const Size(400, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Set the border radius
                            ),
                          ),
                        ))
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
