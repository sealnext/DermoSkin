import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentState();
}

class _AppointmentState extends State<AppointmentPage> {
  String? about =
      "dr. Dhayu Erprida is board certified in Endocrinologists by the Association Doctor of Indo-nesia. His subspecialities/internat";

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
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeColors.primary,
                        backgroundColor: ThemeColors.backgroundPrimary,
                        minimumSize: const Size(30, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: ThemeColors.primary,
                              width: 1.5), // Black border
                        ),
                      ),
                      child: Text(generateHourTexts()[index]),
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
            onPressed: () {},
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
