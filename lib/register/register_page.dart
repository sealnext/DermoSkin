import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTop;
  const RegisterPage({super.key, this.onTop});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;
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
    else if(type == "confirmPassword")
    {
        setState(() {
          confirmPasswordErrorText = validateConfirmPassword(value!);
        });
    }
    else
    {
      setState(() {
        emailErrorText = validateEmail(_emailController.text);
        passwordErrorText = validatePassword(_passwordController.text);
        confirmPasswordErrorText = validateConfirmPassword(_confirmPasswordController.text);
      });
    }
  }

  String? validateEmail(String value) {
    setState(() {
      validate = false;
    });
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if(value.isEmpty) {
      return "Value Can't Be Empty";
    }
    if(!emailRegExp.hasMatch(value)) {
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
    if(value.isEmpty) {
      return "Value Can't Be Empty";
    }
    if(value.length < 8) {
      return "Value needs to have at least 8 characters!";
    }
    setState(() {
      validate = true;
    });
    return null;
  }

  String? validateConfirmPassword(String value) {
    setState(() {
      validate = false;
    });
    if(value.isEmpty)
      return "Value Can't Be Empty";
    if(value.length < 8)
      return "Value needs to have at least 8 characters!";
    if(value != _passwordController.text)
      return "Value is not the same as the password";
    setState(() {
      validate = true;
    });
    return null;
  }

  void createAccount() async {
    if (validate) {
      showDialog(context: context, builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found')
          print("User not found");
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
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
                    "Lets create an account for you"
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
                const SizedBox(height: 20,),
                TextField(
                  onChanged: (value) { validateInputs(value, "confrimPassword");},
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      errorText: confirmPasswordErrorText,
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
                    child: Text("Sign Up",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onPressed: (){
                    validateInputs(null, "button");
                    createAccount();
                  },
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
                    Text("Already have an account?"),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTop,
                      child:Text(
                        "Login now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                        ),
                      ) ,
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
