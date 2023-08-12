import 'package:flutter/material.dart';

import 'package:dermo/utils/constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

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
    return BottomNavigationBar(
      backgroundColor: AppColor.white,
      elevation: 0.0,
      showSelectedLabels:
      true, // sau `false` dacă doriți să eliminați etichetele
      showUnselectedLabels:
      true, // sau `false` dacă doriți să eliminați etichetele
      selectedItemColor: AppColor.primary, // Culoarea elementului selectat
      unselectedItemColor: Colors.grey, // Culoarea elementelor neselectate
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
          activeIcon: _buildIcon(Icons.home, 0), // Se adaugă aceasta linie
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
    );
  }
}