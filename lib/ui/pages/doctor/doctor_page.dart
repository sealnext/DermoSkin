import 'package:dermo/ui/pages/doctor/about_doctor_page.dart';
import 'package:dermo/ui/pages/doctor/address_doctor_page.dart';
import 'package:dermo/ui/pages/doctor/appointment_page.dart';
import 'package:dermo/utils/constants.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(length:  3, child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // A leading button which acts as the back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // This pops the current screen off the navigation stack
          },
        ),
        title: Text('Doctor Profile'),
        centerTitle: true,
        backgroundColor: AppColor.primary,
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
                    width: 80,  // Match the width of the image
                    height: 80, // Match the height of the image
                    decoration: BoxDecoration(
                      color: AppColor.backgroundPrimary, // Set the background color
                      borderRadius: BorderRadius.circular(15), // Ensure the container also has rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.3), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset: Offset(0, 3), // Changes position of shadow
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
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                    child: Container(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("dr. Domnu Exemplu",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 3,),
                          Text("Cardeologie",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.gray2
                            ),
                          ),
                          const SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,  // Using built-in material star icon
                                color: AppColor.orange,  // Set the color of the star icon to yellow (or any color of your choice)
                              ),
                              // Text widget on the right
                              Text(
                                "4.8",  // Replace with your actual review count
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColor.gray2,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                "|",  // Unicode character for a bullet point
                                style: TextStyle(
                                  fontSize: 15,  // Adjust size to your liking
                                  color: AppColor.gray2,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                "128 Reviews",  // Replace with your actual review count
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColor.gray2,
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
                  borderRadius: BorderRadius.circular(25),  // sets a corner radius of 15
                  color: AppColor.gray,
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
  secondRow () {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Patients Column
          Column(
            children: [
              Text(
                '123',  // Replace with your actual patient count
                style: TextStyle(
                  fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('Patients',
              style: TextStyle(
                  fontSize: 15,
                  color: AppColor.gray2
              ),),
            ],
          ),
          // Vertical Separator
          Container(
            height: 30,
            width: 1.5,
            color: AppColor.gray2,
          ),
          // Years Experience Column
          Column(
            children: [
              Text(
                '10',  // Replace with your actual years of experience
                style: TextStyle(
                  fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('Experience',
                style: TextStyle(
                    fontSize: 15,
                    color: AppColor.gray2
                ),),
            ],
          ),
          // Vertical Separator
          Container(
            height: 30,
            width: 1.5,
            color: AppColor.gray2,
          ),
          // Reviews Column
          Column(
            children: [
              Text(
                '456',  // Replace with your actual review count
                style: TextStyle(
                  fontSize: 15,
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text('Reviews',
              style: TextStyle(
                fontSize: 15,
                  color: AppColor.gray2
              ),),
            ],
          ),
        ],
      ),
    );
  }

  //tabs
  tabsFunction() {
    return Container(
      height: 490,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColor.primary,
              indicatorColor: AppColor.primary,
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
