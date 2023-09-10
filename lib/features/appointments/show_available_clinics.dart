import 'package:dermo/features/appointments/appointments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/resources/color_manager.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiaXZhbmJ1bWJ1YyIsImEiOiJjbGM1YnpwMWMwYXhyM3ByeG9tbHo5bTJyIn0.lPqP7l2vFYq0eC3d4Kx5Xg';

class ShowAvailableClinics extends StatefulWidget {
  final String? specialty;
  final String? city;
  final DateTime? date;

  const ShowAvailableClinics({
    Key? key,
    required this.specialty,
    required this.city,
    required this.date,
  }) : super(key: key);

  @override
  State<ShowAvailableClinics> createState() => _ShowAvailableClinicsState();
}

class _ShowAvailableClinicsState extends State<ShowAvailableClinics> {

  int? _indexSelected;
  String? _hourSelected;
  String? _doctorName;
  Map<String, List<String>> generateHourTexts(String doctor) {
    List<String> hours = [];

    var map = Map<String, List<String>>();
    for (int i = 9; i <= 17; i++) {
      String hour = (i % 12).toString().padLeft(2, '0');
      String meridiem = i < 12 ? "pm" : "am";
      hours.add("$hour:00 $meridiem");
    }
    map[doctor] = hours;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ThemeColors.backgroundPrimary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeColors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Clinics available ",
            style:
            TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black),
          ),
          centerTitle: true,
        ),

        body: widget.specialty == null || widget.city == null || widget.date == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Time slots available",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.black), // Center the text within the row
                textAlign: TextAlign.start,
                softWrap: true,
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(widget.date!),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      // Replace with your theme color
                      color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    // Replace with your theme color
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: ListView(children: [
                  _availableClinic(
                      doctorName: "Maria Castana",
                      doctorProfession: widget.specialty!,
                      date: DateFormat('dd/MM/yyyy').format(widget.date!),
                      address: widget.city!,
                      rank: "4.9/5",
                      reviews: "120",
                      clinicLocation: "SkinCa. Clinic",
                      imageUrl:
                      "https://www.yourfreecareertest.com/wp-content/uploads/2021/11/become_a_dermatologist.jpg",
                      about: "Clinica buna!",
                      latitude: 45.735731268228406,
                      longitude:  21.228636630532748
                  ),
                  _availableClinic(
                      doctorName: "Alexia Rusnac",
                      doctorProfession: widget.specialty!,
                      date: DateFormat('dd/MM/yyyy').format(widget.date!),
                      address: widget.city!,
                      rank: "5/5",
                      reviews: "30",
                      clinicLocation: "DermCenter",
                      imageUrl:
                      "https://www.isdin.com/en-US/blog/wp-content/uploads/2020/10/Dermatologist-Recommended-Sunscreens-ISDIN.png",
                      about: "Clinica buna",
                      latitude: 45.735731268228406,
                      longitude:  21.228636630532748
                  ),
                  _availableClinic(
                      doctorName: "Cabral Popescu",
                      doctorProfession: widget.specialty!,
                      date: DateFormat('dd/MM/yyyy').format(widget.date!),
                      address: widget.city!,
                      rank: "4.2/5",
                      reviews: "40",
                      clinicLocation: "AllerCare",
                      imageUrl:
                      "https://ucmscdn.healthgrades.com/83/1c/4654002b4331b626e94ed6e95a66/image-doctor-standing-outside-with-stethoscope.jpg",
                      about: "Clinica buna!",
                      latitude: 45.735731268228406,
                      longitude:  21.228636630532748
                  )
                ]),
              ),
            ],
          ),
        )
    );
  }

  Widget _availableClinic({
    required String doctorName,
    required String doctorProfession,
    required String date,
    required String address,
    required String rank,
    required String reviews,
    required String clinicLocation,
    required String imageUrl,
    required String about,
    required double latitude,
    required double longitude,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons
                              .star, // Using built-in material star icon
                          color: Colors
                              .orange, // Set the color of the star icon to yellow (or any color of your choice)
                        ),
                        // Text widget on the right
                        Text(
                          "$rank", // Replace with your actual review count
                          style: TextStyle(
                            fontSize: 15,
                            color: ThemeColors.gray,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "|", // Unicode character for a bullet point
                          style: TextStyle(
                            fontSize: 15, // Adjust size to your liking
                            color: ThemeColors.gray,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "$reviews Reviews", // Replace with your actual review count
                          style: TextStyle(
                            fontSize: 15,
                            color: ThemeColors.gray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_pin,
                color: ThemeColors.primary,
                size: 20,
              ),
              Text(
                "Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "$address",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 15,),
          Text(
            "Day appointment",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5,),
          Text(
            "$date",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            child: Row(
              children: List.generate(
                generateHourTexts(doctorName)[doctorName]!.length,
                    (index) => Row(
                  children: [
                    if (index != 0)
                      const SizedBox(
                          width:
                          10), // Add space of 10 units except before the first button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _indexSelected = index;
                          _hourSelected = generateHourTexts(doctorName)[doctorName]?[index];
                          _doctorName = doctorName;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeColors.primary,
                        backgroundColor: index == _indexSelected && _doctorName == doctorName ? ThemeColors.primary : ThemeColors.backgroundPrimary,
                        minimumSize: const Size(30, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: ThemeColors.primary,
                              width: 1.5), // Black border
                        ),
                      ),
                      child: Text(generateHourTexts(doctorName)[doctorName]![index],
                        style: TextStyle(
                            color: index == _indexSelected && _doctorName == doctorName ? Colors.white : ThemeColors.primary
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text('Details'),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              height: 420,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    "Welcome to our clinic, your one-stop healthcare destination. Located at the heart of $address, our state-of-the-art facility is equipped with the latest medical technology to provide you with the best care possible.",
                                    style: TextStyle(fontSize: 16),
                                    softWrap: true,
                                  ),
                                  const SizedBox(height: 20,),
                                  const Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: ThemeColors.primary,
                                        size: 20,
                                      ),
                                      Text(
                                        "Location map",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 350,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: ThemeColors.primary.withOpacity(0.3),
                                            // changes position of shadow
                                            blurRadius: 7,
                                            offset: const Offset(0, 1)),
                                      ],
                                    ),
                                    child: FlutterMap(
                                      options: MapOptions(
                                          center: new LatLng(latitude, longitude), minZoom: 5, maxZoom: 30, zoom: 13),
                                      nonRotatedChildren: [
                                        TileLayer(
                                          urlTemplate:
                                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                                          additionalOptions: const {
                                            'accessToken': MAPBOX_ACCESS_TOKEN,
                                            'id': 'mapbox/streets-v11'
                                          },
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              point: new LatLng(latitude, longitude)!,
                                              builder: (context) {
                                                return Container(
                                                  child: const Icon(
                                                    Icons.location_pin,
                                                    color: ThemeColors.primary,
                                                    size: 40,
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                          color: Colors.white
                      ),
                    ),
                  ),
                  child: const Text(
                    "See details",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: ThemeColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {
                    if (_hourSelected == null) {
                      return;
                    }
                    var future = FutureAppointment(doctorName: doctorName, doctorProfession: doctorProfession, reason: 'Monthly check-up', date: date, duration: _hourSelected!, clinicLocation: clinicLocation, imageUrl: imageUrl);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentPage(future),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("Book",
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
}