import 'package:auto_route/auto_route.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/logic/use_cases/sign_out_use_case.dart';
import 'package:dermo/ui/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';
import 'notification.dart';
import 'profile.dart';
import 'appearance.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _signOut = injector<SignOutUseCase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.backgroundPrimary,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              // Avatar cu Text
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    // Replace with actual image
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/564x/74/d7/b0/74d7b05c3476e062ca7c26452ffb22cb.jpg'),
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
                        user.displayName ?? 'User',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _signOut();
                    },
                    child: const Icon(Icons.logout),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),

              const SizedBox(height: 40),

              // Item-uri cu icons

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
                        const Divider(),
                        const SizedBox(height: 10),
                        buildListItem(Icons.notifications, 'Notifications',
                            const NotificationPage()),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        buildListItem(Icons.dark_mode, 'Appearance',
                            const AppearancePage()),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        buildListItem(Icons.feedback, 'Feedback'),
                        const SizedBox(height: 10),
                        const Divider(),
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
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ],
                ),
              ),

              // Row de jos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Privacy Policy'),
                      // Textul tău
                      SizedBox(width: 3.0),
                      Icon(Icons.arrow_forward_ios, size: 10.0),
                      // Icon-ul tău
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Imprint'),
                      // Textul tău
                      SizedBox(width: 3.0),
                      Icon(Icons.arrow_forward_ios, size: 10.0),
                      // Icon-ul tău
                    ],
                  ),
                  DropdownButton<String>(
                    underline: Container(),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 17),
                    value: 'English',
                    items: const [
                      DropdownMenuItem(
                          value: 'English', child: Text('English')),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  // Funcție pentru crearea itemilor cu icons
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
              Text(text, style: const TextStyle(fontSize: 18.0)),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
