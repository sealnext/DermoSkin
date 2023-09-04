import 'package:auto_route/annotations.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/logic/managers/user_manager.dart';
import 'package:dermo/ui/shared_widgets/user_avatar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dermo/core/resources/color_manager.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userManager = injector<UserManager>();

  Widget _buildAppointment({
    required String doctorName,
    required String doctorProfession,
    required String reason,
    required String date,
    required String duration,
    required String clinicLocation,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          // Conținutul existent
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.grey, // sau orice altă culoare
                        borderRadius:
                            BorderRadius.circular(15), // Radiusul colțurilor
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DR. $doctorName, $doctorProfession"),
                          Text(
                            reason,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Noua coloană cu steaua și scorul
          const Row(
            children: [
              Icon(
                Icons.star,
                color: Color.fromARGB(255, 252, 201, 33),
              ),
              Text(
                '4.9',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallItem({required IconData icon, required String label}) {
    Color containerColor = ThemeColors.white;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    containerColor = Colors.grey[300] ?? ThemeColors.white;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    containerColor = ThemeColors.white;
                  });
                  // Aici poți adăuga acțiunea care se întâmplă la apăsare
                },
                onTapCancel: () {
                  setState(() {
                    containerColor = ThemeColors.white;
                  });
                },
                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 200), // Durata animației
                  curve: Curves.easeOut, // Tipul de curba pentru animatie
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: ThemeColors.primary, size: 30),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          color: ThemeColors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.backgroundPrimary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${_userManager.user.firstName.value} ${_userManager.user.lastName.value}",
                              style: const TextStyle(fontSize: 24)),
                          const Text(
                            "Keep healthy!",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      // Replace with actual image
                      backgroundImage:
                          UserAvatarViewModel(avatar: _userManager.user.avatar)
                              .avatarImageProvider(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // const SearchDoctor(),
                const SizedBox(height: 20),
                _buildTipContainer(),
                Row(
                  children: [
                    _buildSmallItem(icon: Icons.person, label: 'Doctor'),
                    const SizedBox(width: 16.0),
                    _buildSmallItem(
                        icon: Icons.local_hospital, label: 'Hospital'),
                    const SizedBox(width: 16.0),
                    _buildSmallItem(
                        icon: Icons.headset_mic, label: 'Consultant'),
                    const SizedBox(width: 16.0),
                    _buildSmallItem(icon: Icons.book_online, label: 'Recipe'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top doctors",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildAppointment(
                        doctorName: "John Doe",
                        doctorProfession: "",
                        reason: "Cardiologist",
                        date: "15/05/23",
                        duration: "09:15-10:10",
                        clinicLocation: "RS. Sardjito",
                        imageUrl:
                            "https://www.jeanlouismedical.com/img/doctor-profile-small.png",
                      ),
                      _buildAppointment(
                        doctorName: "Jane Smith",
                        doctorProfession: "",
                        reason: "Neurologist",
                        date: "20/05/23",
                        duration: "11:00-11:45",
                        clinicLocation: "RS. Sardjito",
                        imageUrl:
                            "https://www.henrymayo.com/app/files/public/dhanda.l--0002.jpg",
                      ),
                      _buildAppointment(
                        doctorName: "Jinsa Brown",
                        doctorProfession: "",
                        reason: "Orthopedic Surgeon",
                        date: "25/05/23",
                        duration: "14:30-15:00",
                        clinicLocation: "RS. Sardjito",
                        imageUrl:
                            "https://www.kauveryhospital.com/doctorimage/recent/Arju_Ashok2021-12-24-12:54:06pm.jpg",
                      ),
                      _buildAppointment(
                        doctorName: "Robert Johnson",
                        doctorProfession: "",
                        reason: "Dermatologist",
                        date: "28/05/23",
                        duration: "09:45-10:30",
                        clinicLocation: "RS. Sardjito",
                        imageUrl:
                            "https://www.kauveryhospital.com/doctorimage/recent/Dr-Rajaram2021-09-09-01:46:06pm.jpg",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildTipContainer() {
    Color containerColor = ThemeColors.primary;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          child: Stack(children: [
            AnimatedContainer(
              width: double.infinity,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: containerColor,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scan your skin now \nto detect potential \ndiseases.",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -30,
              bottom: -1,
              child: Image.asset(
                'assets/images/face.png',
                width: 170, // Poți ajusta dimensiunea aici
                height: 170, // și aici
              ),
            )
          ]),
        );
      },
    );
  }
}
