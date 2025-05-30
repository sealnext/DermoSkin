import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dermo/old/utils/constants.dart';
import 'package:dermo/old/ui/shared/search_doctors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.gray,
                backgroundImage: NetworkImage(imageUrl),
                radius: 25, // ajustează dimensiunea dacă este necesar
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAppointmentDetail(Icons.calendar_today, date),
              _buildAppointmentDetail(Icons.access_time, duration),
              _buildAppointmentDetail(Icons.local_hospital, clinicLocation),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Acesta setează un borderRadius de 10.0
                    ),
                    // alte stiluri pe care doriți să le setați
                  ),
                  child: const Text("See details"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Acesta setează un borderRadius de 10.0
                    ),
                    // alte stiluri pe care doriți să le setați
                  ),
                  child: const AspectRatio(
                    aspectRatio: 1, // acesta este raportul 1:1
                    child: AspectRatio(
                      aspectRatio: 1, // acesta este raportul 1:1
                      child: Center(
                        child: Text(
                          '...',
                          style: TextStyle(
                            color: Colors
                                .black, // Acesta setează culoarea textului la negru
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetail(IconData icon, String info) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(info),
      ],
    );
  }

  Widget _buildSmallItem({required IconData icon, required String label}) {
    Color containerColor = Colors.white;

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
                    containerColor = Colors.grey[300] ?? Colors.white;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    containerColor = Colors.white;
                  });
                  // Aici poți adăuga acțiunea care se întâmplă la apăsare
                },
                onTapCancel: () {
                  setState(() {
                    containerColor = Colors.white;
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
                      Icon(icon, color: AppColor.primary, size: 30),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black,
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
        backgroundColor: AppColor.backgroundPrimary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
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
                          Text(user.displayName ?? 'User',
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
                    const CircleAvatar(
                      radius: 30,
                      // Replace with actual image
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/564x/74/d7/b0/74d7b05c3476e062ca7c26452ffb22cb.jpg'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SearchDoctor(),
                const SizedBox(height: 20),
                _buildTipContainer(),
                Row(
                  children: [
                    _buildSmallItem(icon: Icons.person, label: 'Doctor'),
                    const SizedBox(width: 16.0), // Ajustează lățimea după nevoi
                    _buildSmallItem(
                        icon: Icons.local_hospital, label: 'Hospital'),
                    const SizedBox(width: 16.0), // Ajustează lățimea după nevoi
                    _buildSmallItem(
                        icon: Icons.headset_mic, label: 'Consultant'),
                    const SizedBox(width: 16.0), // Ajustează lățimea după nevoi
                    _buildSmallItem(icon: Icons.book_online, label: 'Recipe'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your appointments",
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
                        doctorProfession: "Cardiologist",
                        reason: "Monthly check-up",
                        date: "15/05/23",
                        duration: "09:15-10:10",
                        clinicLocation: "RS. Sardjito",
                        imageUrl:
                            "https://www.jeanlouismedical.com/img/doctor-profile-small.png",
                      ),
                      _buildAppointment(
                        doctorName: "John Doe",
                        doctorProfession: "Cardiologist",
                        reason: "Monthly check-up",
                        date: "15/05/23",
                        duration: "09:15-10:10",
                        clinicLocation: "RS. Sardjito",
                        imageUrl:
                            "https://www.henrymayo.com/app/files/public/dhanda.l--0002.jpg",
                      ),
                      // Adaugă mai multe programări aici
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildTipContainer() {
    Color containerColor = AppColor.primary;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          onTapDown: (_) {
            setState(() {
              containerColor = AppColor.primary.withOpacity(0.7);
            });
          },
          onTapUp: (_) {
            setState(() {
              containerColor = AppColor.primary;
            });
            // Aici poți adăuga orice acțiune vrei să se întâmple la tap
          },
          onTapCancel: () {
            setState(() {
              containerColor = AppColor.primary;
            });
          },
          child: Stack(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: containerColor,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tips for fighting \nacne",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.visibility, color: Colors.white),
                      SizedBox(width: 5),
                      Text("3.4k views", style: TextStyle(color: Colors.white)),
                    ],
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
