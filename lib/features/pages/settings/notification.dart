import 'package:flutter/material.dart';

import 'package:dermo/core/resources/color_manager.dart';
import 'package:dermo/features/shared_widgets/toggle_switch.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Widget buildNotificationToggle(String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type, style: const TextStyle(fontSize: 18.0)),
          const ToggleSwitch(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ThemeColors.backgroundPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ThemeColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: ListView(
          children: [
            buildSection("Reminders",
                "We will remind you about your upcoming appointments and other important events."),
            const SizedBox(height: 20),
            buildSection("System notifications",
                "Receive notifications about latest news & system updates from us."),
            const SizedBox(height: 20),
            buildSection("Marketing notifications",
                "Receive notifications with personalized offers and information about promotions."),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, String subtitle) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(title),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            buildNotificationToggle("Push"),
            const Divider(color: Color.fromARGB(255, 229, 229, 229)),
            buildNotificationToggle("Email"),
            const Divider(color: Color.fromARGB(255, 229, 229, 229)),
            buildNotificationToggle("SMS"),
          ],
        ),
      )
    ]);
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }
}
