import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_logic.dart';

class RegisterPage extends ConsumerStatefulWidget {
  final void Function() toggleLoginPage;

  const RegisterPage({super.key, required this.toggleLoginPage});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _firstNameErrorText;
  String? _lastNameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> createAccount() async {
    try {
      try {
        await ref.read(authProvider.notifier).signUp(
            email: _emailController.text,
            password: _passwordController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text);
      } catch (e) {
        debugPrint("$e");
      }
    } catch (e) {
      debugPrint("$e");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
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
                const Text("Lets create an account for you"),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      hintText: 'First Name',
                      errorText: _firstNameErrorText,
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
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      hintText: 'Last Name',
                      errorText: _lastNameErrorText,
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
                //email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: _emailErrorText,
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
                      errorText: _passwordErrorText,
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
                  onPressed: () {
                    createAccount();
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
                      "Sign Up",
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
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.toggleLoginPage,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
