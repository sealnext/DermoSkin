import 'package:auto_route/auto_route.dart';
import 'package:dermo/features/pages/appointments/doctor_page.dart';
import 'package:dermo/features/pages/appointments/schedule_selector.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';

@RoutePage()
class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPage();
}

class _AppointmentPage extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Appointments",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ScheduleSelector(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("See details",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Acesta setează un borderRadius de 10.0
                    ),
                    // alte stiluri pe care doriți să le setați
                  ),
                  child: const AspectRatio(
                    aspectRatio: 1, // acesta este raportul 1:1
                    child: Center(
                      child: Text(
                        // todo error UI
                        "...",
                        style: TextStyle(color: Colors.red),
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
}
