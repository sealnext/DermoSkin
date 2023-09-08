import 'package:flutter/material.dart';

class ScheduleSelector extends StatefulWidget {
  const ScheduleSelector({super.key});

  @override
  _ScheduleSelectorState createState() => _ScheduleSelectorState();
}

class _ScheduleSelectorState extends State<ScheduleSelector> {
  double _dragPosition = 0.0;
  bool _isFutureSelected = false;

  @override
  Widget build(BuildContext context) {
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
}
