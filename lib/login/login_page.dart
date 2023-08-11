import 'package:dermo/home/home_page.dart';
import 'package:dermo/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  bool validate = false;

  void validateInputs(String? value, String? type) {
    if(type == "email") {
      setState(() {
        emailErrorText = validateEmail(value!);
      });
    }
    else if(type == "password")
      {
        setState(() {
          passwordErrorText = validatePassword(value!);
        });
      }
    else
      {
        setState(() {
          emailErrorText = validateEmail(_emailController.text);
          passwordErrorText = validatePassword(_passwordController.text);
        });
      }
  }

  String? validateEmail(String value) {
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if(value.isEmpty) {
      setState(() {
        validate = false;
      });
      return "Value Can't Be Empty";
    }
    if(!emailRegExp.hasMatch(value)) {
      setState(() {
        validate = false;
      });
      return "Value has not a valid email format!";
    }
    setState(() {
      validate = true;
    });
    return null;
  }

  String? validatePassword(String value) {
    if(value.isEmpty) {
      setState(() {
        validate = false;
      });
      return "Value Can't Be Empty";
    }
    if(value.length < 8) {
      setState(() {
        validate = false;
      });
      return "Value needs to have at least 8 characters!";
    }
    setState(() {
      validate = true;
    });
    return null;
  }

  void signUserEmail() async {
    if(validate) {
      showDialog(context: context, builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
        );
      } on FirebaseAuthException  catch (e) {
       if(e.code == 'user-not-found')
            print("User not found");
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void signWithGoogle() async {
     await AuthServices.signInWithGoogle();
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void signInWithApple() async {
    await AuthServices.signInWhithApple();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                  const Text(
                    "Welcome back, you've been missed!"
                  ),
                  const SizedBox(height: 30,),
                  //email
                  TextField(
                    onChanged: (value) {validateInputs(value, "email");},
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: emailErrorText,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintStyle: TextStyle(color: Colors.grey[500])
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //password
                  TextField(
                    onChanged: (value) { validateInputs(value, "password");},
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        errorText: passwordErrorText,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintStyle: TextStyle(color: Colors.grey[500])
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    child: Center(
                      child: Text("Sign In",
                        style: TextStyle(
                            fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                    onPressed: (){validateInputs(null, "button"); signUserEmail();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4757E9), // Set the background color here
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Set the border radius
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?"),
                      SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child:Text(
                          "Register now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue
                          ),
                        ) ,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    constraints: BoxConstraints(minWidth: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 2, // Adjust the height as needed
                          color: Colors.grey,
                          width: 150,
                        ),
                        SizedBox(width: 10),
                        Text("Or",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                          ),),
                        SizedBox(width: 10),
                        Container(
                          height: 2, // Adjust the height as needed
                          color: Colors.grey,
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton.icon(
                    onPressed: () { signWithGoogle();},
                    icon: Image.asset(
                      'assets/images/google.png', // Replace with your actual asset path
                      width: 30, // Set the width of the logo as needed
                      height: 30, // Set the height of the logo as needed
                    ),
                    label: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200], // Grey background
                      onPrimary: Colors.black,
                      minimumSize: const Size(400, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.black), // Black border
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Platform.isIOS ? (ElevatedButton.icon(
                    onPressed: (){signInWithApple();},
                    icon: Icon(Icons.apple),
                    label: Text(
                      'Sign in with Apple',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      minimumSize: const Size(400, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Set the border radius
                      ),
                    ),
                  )) : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
