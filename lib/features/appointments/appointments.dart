import 'package:auto_route/auto_route.dart';
import 'package:dermo/features/appointments/add_appointments.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';

class FutureAppointment {
  final String doctorName;
  final String doctorProfession;
  final String reason;
  final String date;
  final String duration;
  final String clinicLocation;
  final String imageUrl;

  FutureAppointment({
    required this.doctorName,
    required this.doctorProfession,
    required this.reason,
    required this.date,
    required this.duration,
    required this.clinicLocation,
    required this.imageUrl,
  });
}


@RoutePage()
class AppointmentPage extends StatefulWidget {
  FutureAppointment? futureAppointment;
  AppointmentPage(this.futureAppointment, {Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPage();
}

class _AppointmentPage extends State<AppointmentPage> {
  double _dragPosition = 0.0;
  bool _isFutureSelected = false;

  late List<FutureAppointment> appointments;

  @override
  void initState() {
    super.initState();

    appointments = [
      FutureAppointment(
        doctorName: "Ion Albu",
        doctorProfession: "Dermatologist",
        reason: "Monthly check-up",
        date: "15/05/23",
        duration: "09:15-10:10",
        clinicLocation: "AllerCare",
        imageUrl: "https://www.jeanlouismedical.com/img/doctor-profile-small.png",
      ),
      FutureAppointment(
        doctorName: "Ion Albu",
        doctorProfession: "Dermatologist",
        reason: "Monthly check-up",
        date: "15/05/23",
        duration: "09:15-10:10",
        clinicLocation: "Clinica Muller",
        imageUrl: "https://www.henrymayo.com/app/files/public/dhanda.l--0002.jpg",
      ),
    ];

    if (widget.futureAppointment != null) {
      appointments.add(widget.futureAppointment!);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAppointment(),
            ),
          );
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              selector(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: _isFutureSelected
                      ? [
                    _buildPastAppointment(
                      doctorName: "Maria Castana",
                      doctorProfession: "Dermatologist",
                      reason: "Acne Treatment",
                      date: "10/01/23",
                      duration: "10:00-11:00",
                      clinicLocation: "SkinCa. Clinic",
                      imageUrl:
                      "https://www.yourfreecareertest.com/wp-content/uploads/2021/11/become_a_dermatologist.jpg",
                      status: "Completed",
                    ),
                    _buildPastAppointment(
                      doctorName: "Alexia Rusnac",
                      doctorProfession: "Dermatologist",
                      reason: "Eczema Consultation",
                      date: "25/02/23",
                      duration: "14:00-15:00",
                      clinicLocation: "DermCenter",
                      imageUrl:
                      "https://www.isdin.com/en-US/blog/wp-content/uploads/2020/10/Dermatologist-Recommended-Sunscreens-ISDIN.png",
                      status: "Cancelled",
                    ),
                    _buildPastAppointment(
                      doctorName: "Cabral Popescu",
                      doctorProfession: "Dermatologist",
                      reason: "Skin Allergy Check-up",
                      date: "05/03/23",
                      duration: "09:30-10:30",
                      clinicLocation: "AllerCare",
                      imageUrl:
                      "https://ucmscdn.healthgrades.com/83/1c/4654002b4331b626e94ed6e95a66/image-doctor-standing-outside-with-stethoscope.jpg",
                      status: "Completed",
                    ),
                  ]
                      : appointments.map((appointment) {
                    return _buildAppointment(
                      doctorName: appointment.doctorName,
                      doctorProfession: appointment.doctorProfession,
                      reason: appointment.reason,
                      date: appointment.date,
                      duration: appointment.duration,
                      clinicLocation: appointment.clinicLocation,
                      imageUrl: appointment.imageUrl,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPastAppointment({
    required String doctorName,
    required String doctorProfession,
    required String reason,
    required String date,
    required String duration,
    required String clinicLocation,
    required String imageUrl,
    required String status, // De exemplu, "Completed" sau "Cancelled"
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Past Appointment",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: status == "Completed" ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
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
                    backgroundColor: ThemeColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "See details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3), // poziția umbrei
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
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

  Widget _buildOption(String title, bool isFuture) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isFutureSelected = isFuture;
          });
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget selector() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 227, 227, 227),
        border: Border.all(
          color: const Color.fromARGB(255, 227, 227, 227),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          _dragPosition += details.delta.dx;
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            if (_dragPosition.abs() > 40) {
              _isFutureSelected = !_isFutureSelected;
            }
            _dragPosition = 0.0;
          });
        },
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: _isFutureSelected
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.44,
                height: 37,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                ),
              ),
            ),
            Row(
              children: [
                _buildOption("Future Schedules", false),
                _buildOption("Past Schedules", true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}