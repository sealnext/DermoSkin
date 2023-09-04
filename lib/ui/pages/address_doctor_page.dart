import 'package:dermo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiaXZhbmJ1bWJ1YyIsImEiOiJjbGM1YnpwMWMwYXhyM3ByeG9tbHo5bTJyIn0.lPqP7l2vFYq0eC3d4Kx5Xg';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  LatLng? myPosition = LatLng(45.75325256700144, 21.2276292086552);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Practice Place",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Timisoara",
          style: TextStyle(
              fontSize: 15, color: AppColor.gray2, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_pin,
              color: AppColor.primary,
              size: 20,
            ),
            Text(
              "Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        myPosition == null
            ? Container(
                height: 50.0,
                // Giving a fixed height to CircularProgressIndicator
                child: Center(
                  child: const CircularProgressIndicator(),
                ),
              )
            : Container(
                height: 300.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.primary.withOpacity(0.3),
                        // changes position of shadow
                        blurRadius: 7,
                        offset: Offset(0, 1)),
                  ],
                ),
                child: FlutterMap(
                  options: MapOptions(
                      center: myPosition, minZoom: 5, maxZoom: 30, zoom: 13),
                  nonRotatedChildren: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: const {
                        'accessToken': MAPBOX_ACCESS_TOKEN,
                        'id': 'mapbox/streets-v11'
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: myPosition!,
                          builder: (context) {
                            return Container(
                              child: const Icon(
                                Icons.location_pin,
                                color: AppColor.primary,
                                size: 40,
                              ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
      ]),
    );
  }
}
