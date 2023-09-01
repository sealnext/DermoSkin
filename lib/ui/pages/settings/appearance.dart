import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  int? selectedPhoneIndex = 0;

  Widget _buildPhoneColumn(
      {required String imagePath, required String title, required int index}) {
    bool isSelected = selectedPhoneIndex == index;

    return Expanded(
      child: Column(
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(title),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedPhoneIndex = isSelected ? null : index;
              });
            },
            child: Stack(
              alignment:
                  Alignment.center, // Acesta va alinia iconița mică în mijloc
              children: [
                const Icon(
                  Icons.circle_outlined,
                  color: ThemeColors.grey,
                  size: 30,
                ),
                if (isSelected) // Afișează doar dacă este selectat
                  const Icon(
                    Icons.circle_rounded,
                    color: ThemeColors.primary,
                    size: 15, // Aceasta este dimensiunea iconiței mici albastre
                  ),
              ],
            ),
          ),
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
            color: ThemeColors.black, // Setează culoarea iconiței aici
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Appearance",
          style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity, // Ocupează întreaga lățime
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aliniaza la stanga
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        "Application theme",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "Selecting a particular option will change the appearance (coloring) of the application according to your preferences.",
              style: TextStyle(color: ThemeColors.grey),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPhoneColumn(
                    imagePath: 'assets/images/screen1.png',
                    title: "Light",
                    index: 0),
                _buildPhoneColumn(
                    imagePath: 'assets/images/screen3.png',
                    title: "Dark",
                    index: 1),
                _buildPhoneColumn(
                    imagePath: 'assets/images/screen2.png',
                    title: "System",
                    index: 2),
              ],
            ),
            const Spacer(),
            // Butonul
            SizedBox(
              width: double.infinity, // Latimea maximă disponibilă
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: ThemeColors.white,
                  backgroundColor: ThemeColors.primary, // Culoarea textului
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0), // Mărește înălțimea butonului
                  shape: RoundedRectangleBorder(
                    // Formează forma butonului
                    borderRadius: BorderRadius.circular(20), // Bordură rotundă
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
