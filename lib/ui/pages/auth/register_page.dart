import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../navigator_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  bool validate = false;

  void validateInputs(String? value, String? type) {
    if (type == "name") {
      setState(() {
        nameErrorText = validateName(value!);
      });
    } else if (type == "email") {
      setState(() {
        emailErrorText = validateEmail(value!);
      });
    } else if (type == "password") {
      setState(() {
        passwordErrorText = validatePassword(value!);
      });
    } else {
      setState(() {
        nameErrorText = validateName(_nameController.text);
        emailErrorText = validateEmail(_emailController.text);
        passwordErrorText = validatePassword(_passwordController.text);
      });
    }
  }

  bool containsOnlyLetters(String input) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(input);
  }

  String? validateName(String value) {
    setState(() {
      validate = false;
    });
    if (value.isEmpty) {
      return "Value Can't Be Empty";
    }
    if (value.length < 3) {
      return "Value needs to have at least 3 characters!";
    }
    if (!containsOnlyLetters(value)) {
      return "Value can only contain letters";
    }
    setState(() {
      validate = true;
    });
    return null;
  }

  String? validateEmail(String value) {
    setState(() {
      validate = false;
    });
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value.isEmpty) {
      return "Value Can't Be Empty";
    }
    if (!emailRegExp.hasMatch(value)) {
      return "Value has not a valid email format!";
    }
    setState(() {
      validate = true;
    });
    return null;
  }

  String? validatePassword(String value) {
    setState(() {
      validate = false;
    });
    if (value.isEmpty) {
      return "Value Can't Be Empty";
    }
    if (value.length < 8) {
      return "Value needs to have at least 8 characters!";
    }
    setState(() {
      validate = true;
    });
    return null;
  }

  void createAccount() async {
    if (validate) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        User? user = userCredential.user;

        if (user != null) {
          await user.updateDisplayName(_nameController.text);
        }

        if (user != null) {

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': _nameController.text,
            'email': _emailController.text
          }, SetOptions(merge: true));

          // saveUserData(_nameController.text, )
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print("User not found");
        }
      } on FirebaseException catch (e) {
        print(e.code);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
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
                  onChanged: (value) {
                    validateInputs(value, "name");
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Full Name',
                      errorText: nameErrorText,
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
                  onChanged: (value) {
                    validateInputs(value, "email");
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: emailErrorText,
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
                  onChanged: (value) {
                    validateInputs(value, "password");
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      errorText: passwordErrorText,
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
                    validateInputs(null, "button");
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
                      onTap: widget.onTap,
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
