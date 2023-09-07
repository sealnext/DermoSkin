import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/logic/data_objects/value_objects/last_name.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:flutter/material.dart';

import 'package:dermo/logic/use_cases/sign_up_use_case.dart';
import 'package:dermo/core/utility/injector.dart';

class RegisterPage extends StatefulWidget {
  final void Function() toggleLoginPage;

  const RegisterPage({super.key, required this.toggleLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signUp = injector<SignUpUseCase>();

  String? _firstNameErrorText;
  String? _lastNameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  void createAccount() async {
    FirstName? firstName;
    try {
      firstName = FirstName(_firstNameController.text);
    } catch (e) {
      _firstNameErrorText = e.toString();
      return;
    }
    LastName? lastName;
    try {
      lastName = LastName(_lastNameController.text);
    } catch (e) {
      _lastNameErrorText = e.toString();
      return;
    }
    Email? email;
    try {
      email = Email(_emailController.text);
    } catch (e) {
      _emailErrorText = e.toString();
      return;
    }
    Password? password;
    try {
      password = Password(_passwordController.text);
    } catch (e) {
      _passwordErrorText = e.toString();
      return;
    }
    try {
      await _signUp(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password);
    } catch (e) {
      debugPrint("$e");
      return;
    }
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
