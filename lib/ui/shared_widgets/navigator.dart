import 'package:flutter/material.dart';
import 'package:dermo/old/utils/constants.dart';
import 'package:dermo/old/ui/pages/home/home.dart';
import 'package:dermo/old/ui/pages/appointments/appointments.dart';
import 'package:dermo/ui/pages/rooms/rooms.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Appointments(),
    const RoomsPage(),
    // const Settings(),
  ];

  Widget _buildIcon(IconData iconData, int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? AppColor.primary : Colors.transparent,
      ),
      child:
          Icon(iconData, color: _currentIndex == index ? Colors.white : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.white,
        elevation: 0.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0),
            label: '',
            activeIcon: _buildIcon(Icons.home, 0),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.calendar_today, 1),
            label: '',
            activeIcon: _buildIcon(Icons.calendar_today, 1),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.chat, 2),
            label: '',
            activeIcon: _buildIcon(Icons.chat, 2),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.settings, 3),
            label: '',
            activeIcon: _buildIcon(Icons.settings, 3),
          ),
        ],
      ),
    );
  }
}
