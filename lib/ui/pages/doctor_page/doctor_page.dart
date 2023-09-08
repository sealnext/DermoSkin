import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/ui/pages/doctor_page/about_doctor_page.dart';
import 'package:dermo/ui/pages/doctor_page/address_doctor_page.dart';
import 'package:dermo/ui/pages/doctor_page/appointment_page.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Doctor Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: ThemeColors.backgroundPrimary,
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80, // Match the width of the image
                      height: 80, // Match the height of the image
                      decoration: BoxDecoration(
                        color: ThemeColors
                            .backgroundPrimary, // Set the background color
                        borderRadius: BorderRadius.circular(
                            15), // Ensure the container also has rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.primary
                                .withOpacity(0.3), // Shadow color
                            spreadRadius: 1, // Spread radius
                            blurRadius: 6, // Blur radius
                            offset: const Offset(
                                0, 3), // Changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/doctor_ex.jpeg', // Replace with your actual image asset path
                          width: 80, // Set the width of the image
                          height: 80, // Set the height of the image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                      child: SizedBox(
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "dr. Domnu Exemplu",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Cardeologie",
                              style: TextStyle(
                                  fontSize: 15, color: ThemeColors.gray),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons
                                      .star, // Using built-in material star icon
                                  color: Colors
                                      .orange, // Set the color of the star icon to yellow (or any color of your choice)
                                ),
                                // Text widget on the right
                                Text(
                                  "4.8", // Replace with your actual review count
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
                                  "128 Reviews", // Replace with your actual review count
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ThemeColors.gray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(25), // sets a corner radius of 15
                    color: ThemeColors.grey,
                  ),
                  child: secondRow(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: tabsFunction(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //experience , patints and reviews
  secondRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Patients Column
          const Column(
            children: [
              Text(
                '123', // Replace with your actual patient count
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Patients',
                style: TextStyle(fontSize: 15, color: ThemeColors.gray),
              ),
            ],
          ),
          // Vertical Separator
          Container(
            height: 30,
            width: 1.5,
            color: ThemeColors.gray,
          ),
          // Years Experience Column
          const Column(
            children: [
              Text(
                '10', // Replace with your actual years of experience
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Experience',
                style: TextStyle(fontSize: 15, color: ThemeColors.gray),
              ),
            ],
          ),
          // Vertical Separator
          Container(
            height: 30,
            width: 1.5,
            color: ThemeColors.gray,
          ),
          // Reviews Column
          const Column(
            children: [
              Text(
                '456', // Replace with your actual review count
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Reviews',
                style: TextStyle(fontSize: 15, color: ThemeColors.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //tabs
  tabsFunction() {
    return const SizedBox(
      height: 490,
      child: Column(
        children: [
          TabBar(
            labelColor: ThemeColors.primary,
            indicatorColor: ThemeColors.primary,
            tabs: [
              Tab(text: "Appointment"),
              Tab(text: "Address"),
              Tab(text: "About"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                AppointmentPage(),
                Address(),
                AboutDoctorPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
