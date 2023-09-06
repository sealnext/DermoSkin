import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/ui/shared_widgets/user_avatar_view_model.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/logic/managers/user_manager.dart';
import 'package:dermo/core/utility/injector.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

enum Gender { male, female }

class _EditProfilePageState extends State<EditProfilePage> {
  final _userManager = injector<UserManager>();

  String name = '';
  String address = '';
  String gender = '';
  String email = '';
  DateTime dateOfBirth = DateTime.now();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  _fetchUserData() async {
    setState(() {
      name = _userManager.user.firstName.value;
      gender = _userManager.user.firstName.value;
      email = _userManager.user.email.value;

      nameController.text = name;
      addressController.text = address;
      emailController.text = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.backgroundPrimary,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ThemeColors.backgroundPrimary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // profile picture
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage:
                        UserAvatarViewModel(avatar: _userManager.user.avatar)
                            .avatarImageProvider(), // Placeholder image
                  ),
                  const CircleAvatar(
                    radius:
                        25.0,
                    backgroundColor: ThemeColors.white,
                    child: CircleAvatar(
                      backgroundColor: ThemeColors.primary,
                      radius: 20.0,
                      child: Icon(Icons.camera_alt, color: ThemeColors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // name
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Name",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: nameController,
                onChanged: (text) => setState(() {
                  try {
                    _userManager.user.firstName = FirstName(text);
                  } on InvalidFirstNameException catch (e) {
                    print(e);
                  }
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 182, 182, 182)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Date of birth",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      dateOfBirth = pickedDate;
                    });
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 182, 182, 182)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(7.0)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dateOfBirth.toLocal().toString().split(' ')[0],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Gender",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                        border:
                            Border.all(color: Colors.grey),
                      ),
                      margin: const EdgeInsets.only(
                          right:
                              8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: "male",
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                            activeColor: Colors.black,
                            fillColor: MaterialStateProperty.all(Colors.black),
                          ),
                          const Text("Male",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                        border:
                            Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: "female",
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                            activeColor: Colors.black,
                            fillColor: MaterialStateProperty.all(Colors.black),
                          ),
                          const Text("Female",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Address",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: addressController,
                onChanged: (text) => setState(() {
                  address = text;
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 182, 182, 182)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Email",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                enabled: false,
                style: const TextStyle(fontSize: 16),
                controller: emailController,
                onChanged: (text) => setState(() {
                  try {
                    _userManager.user.email = Email(text);
                  } on InvalidEmailException catch (e) {
                    print(e);
                  }
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 182, 182, 182)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0),
                ),
              ),
              const Spacer(),
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            ThemeColors.primary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        _userManager.syncUserWithDb();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
