import 'package:auto_route/auto_route.dart';
import 'package:dermo/features/auth/auth_logic.dart';
import 'package:dermo/features/user/user_logic.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notification.dart';
import 'profile.dart';
import 'appearance.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    MyUser user = ref.watch(userProvider);

    return Scaffold(
        backgroundColor: ThemeColors.backgroundPrimary,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(color: Color.fromARGB(255, 229, 229, 229)),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300?img=52"),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Settings',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      ),
                      Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await ref.read(authProvider.notifier).signOut();
                    },
                    child: const Icon(Icons.logout),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(color: Color.fromARGB(255, 229, 229, 229)),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  // margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildListItem(Icons.account_circle, 'Profile',
                            const EditProfilePage()),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 229, 229, 229)),
                        const SizedBox(height: 10),
                        buildListItem(Icons.notifications, 'Notifications',
                            const NotificationPage()),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 229, 229, 229)),
                        const SizedBox(height: 10),
                        buildListItem(Icons.dark_mode, 'Appearance',
                            const AppearancePage()),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 229, 229, 229)),
                        const SizedBox(height: 10),
                        buildListItem(Icons.feedback, 'Feedback'),
                        const SizedBox(height: 10),
                        const Divider(
                            color: Color.fromARGB(255, 229, 229, 229)),
                        const SizedBox(height: 10),
                        buildListItem(
                            Icons.article_outlined, 'Terms of Service'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ThemeColors.secondary,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.support_agent, size: 30.0),
                    SizedBox(height: 8.0),
                    Text(
                      ' How can we help you?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Privacy Policy'),
                      SizedBox(width: 3.0),
                      Icon(Icons.arrow_forward_ios, size: 10.0),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Imprint'),
                      SizedBox(width: 3.0),
                      Icon(Icons.arrow_forward_ios, size: 10.0),
                    ],
                  ),
                  DropdownButton<String>(
                    underline: Container(),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                    value: 'English',
                    items: const [
                      DropdownMenuItem(
                          value: 'English',
                          child: Text(
                            'English',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          )),
                      DropdownMenuItem(
                          value: 'Spanish',
                          child: Text(
                            'Spanish',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          )),
                      DropdownMenuItem(
                          value: 'Français',
                          child: Text(
                            'Français',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          )),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  Widget buildListItem(IconData icon, String text, [Widget? page]) {
    return GestureDetector(
      onTap: page != null
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => page,
                ),
              );
            }
          : null,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon, size: 25.0),
              const SizedBox(width: 16.0),
              Text(text, style: const TextStyle(fontSize: 16.0)),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
