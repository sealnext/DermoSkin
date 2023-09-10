import 'package:auto_route/auto_route.dart';
import 'package:dermo/features/user/user_logic.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

enum Gender { male, female }

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  String name = '';
  String address = '';
  String gender = '';
  String email = '';
  DateTime dateOfBirth = DateTime.now();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    MyUser user = ref.read(userProvider);
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userProvider, (MyUser? prev, MyUser user) {
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      emailController.text = user.email;
    });
    // AsyncValue<void> updateUserState = ref.watch(updateUserProvider);
    return LoaderOverlay(
        child: Scaffold(
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                        // backgroundImage:
                        //     UserAvatarViewModel(avatar: _userManager.user.avatar)
                        //         .avatarImageProvider(),
                      ),
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundColor: ThemeColors.white,
                        child: CircleAvatar(
                          backgroundColor: ThemeColors.primary,
                          radius: 20.0,
                          child:
                              Icon(Icons.camera_alt, color: ThemeColors.white),
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
                    controller: firstNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 182, 182, 182)),
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
                          vertical: 10.0, horizontal: 15.0),
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
                          vertical: 15.0, horizontal: 15.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 182, 182, 182)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
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
                            border: Border.all(color: Colors.grey),
                          ),
                          margin: const EdgeInsets.only(right: 8.0),
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
                                fillColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              const Text("Male",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(color: Colors.grey),
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
                                fillColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              const Text("Female",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
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
                    controller: lastNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 182, 182, 182)),
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
                          vertical: 10.0, horizontal: 15.0),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 182, 182, 182)),
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
                          vertical: 10.0, horizontal: 15.0),
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
                            backgroundColor: ThemeColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            context.loaderOverlay.show();
                            final newUser = MyUser(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: email,
                                avatar: '');
                            await ref
                                .read(updateUserProvider.notifier)
                                .updateUser(newUser);
                            if (context.mounted) {
                              if (context.loaderOverlay.visible) {
                                context.loaderOverlay.hide();
                              }
                              Navigator.of(context).pop();
                            }
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
            )));
  }
}
