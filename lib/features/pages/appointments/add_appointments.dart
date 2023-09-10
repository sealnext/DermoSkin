import 'package:dermo/features/pages/appointments/show_available_clinics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/resources/color_manager.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({super.key});

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final TextEditingController dropdown1_Controller = TextEditingController();
  final List<String> list1 = <String>[
    'Allergy and Immunology',
    'Anatomic Pathology',
    'Anesthesia and Intensive Care',
    'Cardiology',
    'Surgery',
    'Endocrinology',
    'Dermatology',
    'Gastroenterology',
    'Hematology',
    'Infectious Diseases',
    'Nephrology',
    'Neurology',
    'Obstetrics and Gynecology',
    'Oncology',
    'Ophthalmology',
    'Orthopedic Surgery',
    'Pediatrics',
    'Psychiatry',
    'Pulmonology',
    'Radiology',
    'Rheumatology',
    'Urology'
  ];

  final List<String> citiesOfRomania = [
    'Bucharest',
    'Cluj-Napoca',
    'Timisoara',
    'Iasi',
    'Constanta',
    'Craiova',
    'Brasov',
    'Galati',
    'Ploiesti',
    'Oradea',
    // Add more cities here
  ];
  String? dropDownValue1;
  String? dropDownValue2;
  DateTime calendarValue = DateTime.now();

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
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
            color: ThemeColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Add appointment",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Scheduling in the clinic    ",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.black), // Center the text within the row
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Select the appointment details below to see the available clinics.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.black),
                    softWrap: true,
                  ),
                  const SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0), // Rounded corner on top-left
                      topRight: Radius.circular(12.0), // Rounded corner on top-right
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(color: Colors.white), // White Border
                        ),
                        enabledBorder: InputBorder.none,  // Remove bottom bar when enabled
                        focusedBorder: InputBorder.none,  // Remove bottom bar when focused
                      ),
                      hint:Padding(
                        padding: const EdgeInsets.only(left: 16), // Add your desired padding here
                        child: Text("Select the specialty"),
                      ),
                      value: dropDownValue1,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue1 = newValue!;
                        });
                      },
                      items: list1.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16), // Add your desired padding here
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0), // Rounded corner on top-left
                      bottomRight: Radius.circular(12.0), // Rounded corner on top-right
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(color: Colors.white), // White Border
                        ),
                        enabledBorder: InputBorder.none,  // Remove bottom bar when enabled
                        focusedBorder: InputBorder.none,  // Remove bottom bar when focused
                      ),
                      hint:Padding(
                        padding: const EdgeInsets.only(left: 16), // Add your desired padding here
                        child: Text("Select the city"),
                      ),
                      value: dropDownValue2,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue2 = newValue!;
                        });
                      },
                      items: citiesOfRomania.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16), // Add your desired padding here
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 2,),
                  TableCalendar(
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        calendarValue = selectedDay;
                      });
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(calendarValue, date);
                    },
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: calendarValue,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week',
                    },
                    headerStyle: HeaderStyle(
                      formatButtonDecoration: BoxDecoration(
                        color:
                        ThemeColors.primary, // The background color of the button
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      formatButtonTextStyle: const TextStyle(
                        color: Colors.white, // Text color of the button
                      ),
                      leftChevronIcon: const Icon(Icons.chevron_left,
                          color:
                          ThemeColors.primary), // Change the left arrow color here
                      rightChevronIcon: const Icon(Icons.chevron_right,
                          color:
                          ThemeColors.primary), // Change the right arrow color here
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      // Change the color of the weekdays text
                      weekdayStyle: TextStyle(color: ThemeColors.primary),
                      // Change the color of the weekend text
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color:
                        ThemeColors.primary, // Background color of the selected day
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      // ... other calendar styles ...
                    ),
                  ),
                  const SizedBox(height: 50,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowAvailableClinics(
                              specialty: dropDownValue1,
                              city: dropDownValue2,
                              date: calendarValue),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.primary,
                      minimumSize: const Size(500, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Verify disponibility",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        dropDownValue1 = null;
                        dropDownValue2 = null;
                        calendarValue = DateTime.now();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(500, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.white
                        ),
                      ),
                    ),
                    child: const Text(
                      "Reset the filter",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: ThemeColors.primary),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
