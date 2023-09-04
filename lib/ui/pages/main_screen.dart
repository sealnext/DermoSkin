import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/old/ui/pages/appointments/appointments.dart';
import 'package:dermo/ui/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
// 1. Wrap Icon in Center Widget
  Widget _buildIcon(IconData iconData, int index) {
    return Center(
      child: SizedBox(
        height: 40,
        child: Center(
          child: Icon(
            iconData,
            color: _currentIndex == index ? ThemeColors.primary : Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        RoomsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return SizedBox(
          height: 125, // Setează înălțimea dorită
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.home, 0),
                label: '',
                activeIcon: _buildIcon(Icons.home, 0),
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.chat, 1),
                label: '',
                activeIcon: _buildIcon(Icons.chat, 1),
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.settings, 2),
                label: '',
                activeIcon: _buildIcon(Icons.settings, 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
