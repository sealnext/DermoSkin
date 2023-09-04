import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/ui/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
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
              icon: Icon(Icons.home_outlined, color: ThemeColors.primary),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.chat, color: ThemeColors.primary),
              icon: Icon(Icons.chat_outlined, color: ThemeColors.primary),
              label: 'Chat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings, color: ThemeColors.primary),
              icon: Icon(Icons.settings_outlined, color: ThemeColors.primary),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
