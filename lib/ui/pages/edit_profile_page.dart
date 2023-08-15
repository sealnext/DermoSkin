import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_data.dart';
import '../../service/user_service.dart';
import '../../utils/constants.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

enum Gender { male, female }

class _EditProfilePageState extends State<EditProfilePage> {
  // retrieve data from db for this shit
  final user = FirebaseAuth.instance.currentUser!;
  final UserService _userService = UserService();
  String name = '';
  String address = '';
  String gender = '';
  DateTime dateOfBirth = DateTime.now();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  _fetchUserData() async {
    UserData userData = await _userService.getUserDataByUID(user.uid);
    setState(() {
      name = userData.name;
      address = userData.address;
      gender = userData.gender;

      nameController.text = name;
      addressController.text = address;

      if (userData.dateOfBirth != "") {
        dateOfBirth = DateTime.parse(userData.dateOfBirth);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundPrimary,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.backgroundPrimary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black, // Setează culoarea iconiței aici
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
              const Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Placeholder image
                  ),
                  CircleAvatar(
                    radius:
                        25.0, // 3.0 pixeli mai mare decât CircleAvatar-ul interior
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20.0,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // name
              Container(
                alignment: Alignment.topLeft, // Aici
                child: const Text(
                  "Name",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: nameController,
                onChanged: (text) => setState(() {
                  name = text;
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(
                    // Aceasta adaugă bordura rotundă
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 182, 182, 182)), // Aceasta face bordura neagră
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Aceasta este bordura când câmpul este activ (focused)
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Aceasta este bordura când câmpul este activat dar nu focused
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0), // Padding în interiorul câmpului
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft, // Aici
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
                      horizontal: 15.0), // A mărit padding-ul vertical
                  side: const BorderSide(
                      color: Color.fromARGB(255, 182, 182, 182)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(7.0)), // Culoarea textului
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dateOfBirth.toLocal().toString().split(' ')[0],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft, // Aici
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
                            Border.all(color: Colors.grey), // Culoarea bordurii
                      ),
                      margin: const EdgeInsets.only(
                          right:
                              8.0), // margin pentru a lăsa spațiu între cele două container-e
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
                              style: TextStyle(color: Colors.black)),
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
                            Border.all(color: Colors.grey), // Culoarea bordurii
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
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft, // Aici
                child: const Text(
                  "Address",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: addressController,
                onChanged: (text) => setState(() {
                  address = text;
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(
                    // Aceasta adaugă bordura rotundă
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 182, 182, 182)), // Aceasta face bordura neagră
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Aceasta este bordura când câmpul este activ (focused)
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Aceasta este bordura când câmpul este activat dar nu focused
                    borderRadius: BorderRadius.circular(7.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 182, 182, 182)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0), // Padding în interiorul câmpului
                ),
              ),
              const Spacer(),
              Column(
                children: <Widget>[
                  // Linie orizontală deasupra butonului
                  const Divider(
                      color: Color.fromARGB(255, 195, 195, 195),
                      thickness: 1.0,
                      height: 1.0),
                  const SizedBox(
                    height: 15,
                  ),
                  // Butonul
// Butonul
                  SizedBox(
                    width: double.infinity, // Latimea maximă disponibilă
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black, // Culoarea textului
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0), // Mărește înălțimea butonului
                        shape: RoundedRectangleBorder(
                          // Formează forma butonului
                          borderRadius:
                              BorderRadius.circular(20), // Bordură rotundă
                        ),
                      ),
                      onPressed: () {
                        UserData userDataToSave = UserData(
                            uid: user.uid,
                            name: name,
                            address: address,
                            gender: gender,
                            dateOfBirth: dateOfBirth.toIso8601String());
                        _userService.setUserData(userDataToSave);
                      },
                      child: const Text("Save"),
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
