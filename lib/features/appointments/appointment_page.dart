import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'appointments.dart';

class AppointmentPageDoctor extends StatefulWidget {
  final String? name;
  final String? image;
  const AppointmentPageDoctor({super.key,  required this.name, required this.image});

  @override
  State<AppointmentPageDoctor> createState() => _AppointmentState();
}

class _AppointmentState extends State<AppointmentPageDoctor> {
  String? about =
      "dr. Dhayu Erprida is board certified in Endocrinologists by the Association Doctor of Indo-nesia. His subspecialities/internat";

  int? _indexSelected;
  String? _hourSelected;
  DateTime _calendarValue = DateTime.now();
  String getFirst129Chars(String input) {
    if (input.length <= 129) {
      return input;
    }
    return input.substring(0, 129);
  }

  List<String> generateHourTexts() {
    List<String> hours = [];

    for (int i = 9; i <= 17; i++) {
      String hour = (i % 12).toString().padLeft(2, '0');
      String meridiem = i < 12 ? "am" : "pm";
      hours.add("$hour:00 $meridiem");
    }
    return hours;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Schedules",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _calendarValue = selectedDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(_calendarValue, date);
            },
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _calendarValue,
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
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Choose time",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            child: Row(
              children: List.generate(
                generateHourTexts().length,
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
                          _hourSelected = generateHourTexts()[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeColors.primary,
                        backgroundColor: _indexSelected == index ? ThemeColors.primary : ThemeColors.backgroundPrimary,
                        minimumSize: const Size(30, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: ThemeColors.primary,
                              width: 1.5), // Black border
                        ),
                      ),
                      child: Text(generateHourTexts()[index],
                        style: TextStyle(
                          color: _indexSelected == index ? Colors.white: ThemeColors.primary,
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              var future = new FutureAppointment(doctorName: widget.name!, doctorProfession: '', reason: 'Monthly check-up', date: DateFormat('dd/MM/yyyy').format(_calendarValue), duration: _hourSelected! , clinicLocation: '', imageUrl: widget.image!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(future),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.primary,
              minimumSize: const Size(500, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: ThemeColors.primary,
                ), // Black border
              ),
            ),
            child: const Text(
              "Book",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}