import 'package:dermo/utils/constants.dart';
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
          Text("Biography Doctor", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black
          ),
          ),
          const SizedBox(height: 20,),
         SingleChildScrollView(
           scrollDirection: Axis.vertical,
          child: Container(
            height: 150,
            child: Text("Dr.	Alan	Stern	was	born	in	DuBois,	Psdsdasdasda dasdasennsylvania	and	is	a	graduate	of	Villanova University.	He	obtained	his	medical	degree	at	Thomas	Jefferson	University	inPhiladelphia.	His	residency	was	at	Thomas	Jefferson	and	its	affiliated	Wills	EyeHospital,	and	he	completed	his	training	with	fellowships	at	the	University	ofConnecticut in	cataract	and	corneal	surgery.",
            style: TextStyle(
              fontSize: 16,
              color: AppColor.gray2
            ),
              softWrap: true,
            ),
          ),
         ),
          const SizedBox(height: 20,),
        Text("Reviews",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black
        ),
        ),
          const SizedBox(height: 20,),
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: reviews()
          )
        ],
      ),
    );
  }

  reviews () {
    return List.generate(10, (index) =>
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.gray, // Background color
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Titlu",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(3, (index) =>
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,  // Using built-in material star icon
                                        color: AppColor.orange,  // Set the color of the star icon to yellow (or any color of your choice)
                                      ),
                                      const SizedBox(width: 5,)
                                    ],
                                  ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ana22' + ",",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.gray2
                                  ),),
                                const SizedBox(width: 5,),
                                Text("4 August 23",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.gray2
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text("Acesta este un muesadjajfnadna daidjadija dadaidnaund dabdbaudhai",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.gray2
                      ),
                      softWrap: true,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,)
          ],
        )
    );
  }
}
