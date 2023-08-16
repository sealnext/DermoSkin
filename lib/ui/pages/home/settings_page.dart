import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dermo/utils/constants.dart';

import '../auth/auth_page.dart';
import '../settings/notification_page.dart';
import '../settings/profile_page.dart';
import '../settings/appearance_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundPrimary,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Linia orizontală
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
                      // Aici puneți codul pe care doriți să îl executați atunci când se atinge iconița
                      signOut();
                    },
                    child: const Icon(Icons.logout),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Linia orizontală
              const Divider(),

              const SizedBox(height: 40),

              // Item-uri cu icons

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  // margin: const EdgeInsets.all(
                  //     20.0), // Acesta setează o margine de 20 pixeli pe toate laturile
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        15.0), // Acesta setează o rază de bordură de 15 pixeli
                    // alte proprietăți ale decoration, dacă sunt necesare...
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

              // Container albastru
              Container(
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.circular(
                      5.0), // Ajustați valoarea pentru a controla rotunjimea colțurilor
                ),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.support_agent,
                        size: 30.0), // mărită dimensiunea dacă e necesar
                    SizedBox(height: 8.0),
                    Text(
                      ' How can we help you?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0), // Creșteți dimensiunea fontului aici
                    ),
                  ],
                ),
              ),

              // Row de jos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Alinează conținutul la stânga
                    children: <Widget>[
                      Text('Privacy Policy'), // Textul tău
                      SizedBox(width: 3.0),
                      Icon(Icons.arrow_forward_ios, size: 10.0), // Icon-ul tău
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Alinează conținutul la stânga
                    children: <Widget>[
                      Text('Imprint'), // Textul tău
                      SizedBox(width: 3.0),
                      Icon(Icons.arrow_forward_ios, size: 10.0), // Icon-ul tău
                    ],
                  ),
                  DropdownButton<String>(
                    underline: Container(),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 17),
                    value: 'English',
                    items: const [
                      DropdownMenuItem(
                          value: 'English', child: Text('English')),
                      // Adăugați mai multe limbi dacă este necesar
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
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
        color: AppColor.white,
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
