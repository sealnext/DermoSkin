import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/ui/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        AppointmentRoute(),
        CameraRoute(),
        RoomsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          animationDuration: const Duration(milliseconds: 300),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: ThemeColors.backgroundPrimary,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: ThemeColors.primary),
              icon: Icon(Icons.home_outlined,
                  color: Color.fromARGB(255, 94, 109, 245)),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Badge(
                  label: Text("2"),
                  child: Icon(Icons.access_time_filled,
                      color: ThemeColors.primary)),
              icon: Badge(
                  label: Text("2"),
                  child: Icon(Icons.access_time, color: ThemeColors.primary)),
              label: 'Appointments',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.camera_alt, color: ThemeColors.primary),
              icon: Icon(Icons.camera_alt_outlined, color: ThemeColors.primary),
              label: 'Scan',
            ),
            NavigationDestination(
              selectedIcon: Badge(
                  label: Text("1"),
                  child: Icon(Icons.chat, color: ThemeColors.primary)),
              icon: Badge(
                  label: Text("1"),
                  child: Icon(Icons.chat_outlined, color: ThemeColors.primary)),
              label: 'Chat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings, color: ThemeColors.primary),
              icon: Icon(Icons.settings_outlined,
                  color: Color.fromARGB(255, 94, 109, 245)),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
