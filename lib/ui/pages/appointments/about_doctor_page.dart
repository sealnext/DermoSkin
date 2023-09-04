import 'dart:math';

import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class AboutDoctorPage extends StatefulWidget {
  const AboutDoctorPage({super.key});

  @override
  State<AboutDoctorPage> createState() => _AboutDoctorPageState();
}

class _AboutDoctorPageState extends State<AboutDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Biography Doctor",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: 150,
              child: Text(
                "Dr.	Alan	Stern	was	born	in	DuBois,	Psdsdasdasda dasdasennsylvania	and	is	a	graduate	of	Villanova University.	He	obtained	his	medical	degree	at	Thomas	Jefferson	University	inPhiladelphia.	His	residency	was	at	Thomas	Jefferson	and	its	affiliated	Wills	EyeHospital,	and	he	completed	his	training	with	fellowships	at	the	University	ofConnecticut in	cataract	and	corneal	surgery.",
                style: TextStyle(fontSize: 16, color: ThemeColors.gray),
                softWrap: true,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Reviews",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: reviews())
        ],
      ),
    );
  }

  reviews() {
    // Listele de date mock pentru a genera review-uri
    final reviewTitles = [
      "Dezamăgitor",
      "Mediu",
      "OK",
      "Foarte bun",
      "Excelent!",
    ];
    final usernames = ["Ana22", "Mike87", "JohnD", "Sara_M", "Florin123"];
    final dates = [
      "4 August 23",
      "22 July 23",
      "1 June 23",
      "15 May 23",
      "28 February 23"
    ];
    final reviewTexts = [
      "Nu m-a impresionat.",
      "Mediu, nimic special.",
      "Așteptările mele au fost îndeplinite.",
      "Medicul a fost foarte prietenos.",
      "Cel mai bun serviciu!",
    ];

    Random rand = Random(); // Pentru a genera numere aleatoare

    return List.generate(
      10,
      (index) {
        int randomReviewIndex = rand.nextInt(reviewTitles.length);
        int randomStar = randomReviewIndex + 1;
        int randomUser = rand.nextInt(usernames.length);
        int randomDate = rand.nextInt(dates.length);
        int randomText = randomReviewIndex;

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ThemeColors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reviewTitles[randomReviewIndex],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            randomStar,
                            (index) => const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 5)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${usernames[randomUser]} ,',
                              style: const TextStyle(
                                  fontSize: 16, color: ThemeColors.gray),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              dates[randomDate],
                              style: const TextStyle(
                                  fontSize: 16, color: ThemeColors.gray),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        reviewTexts[randomText],
                        style: const TextStyle(
                            fontSize: 16, color: ThemeColors.gray),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
