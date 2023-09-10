import 'package:dermo/features/pages/appointments/doctor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchDoctor extends StatefulWidget {
  const SearchDoctor({super.key});

  @override
  _SearchDoctorState createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _doctorNames = [
    'Sarah Williams',
    'Alex Johnson',
    'Rebecca Lee',
    'John Doe'
  ];

  final Map<String, String> _images = {
    'Sarah Williams' : "https://www.yourfreecareertest.com/wp-content/uploads/2021/11/become_a_dermatologist.jpg",
    'Alex Johnson' :  "https://www.isdin.com/en-US/blog/wp-content/uploads/2020/10/Dermatologist-Recommended-Sunscreens-ISDIN.png",
    'Rebecca Lee': "https://ucmscdn.healthgrades.com/83/1c/4654002b4331b626e94ed6e95a66/image-doctor-standing-outside-with-stethoscope.jpg",
    'John Doe' :  "https://www.jeanlouismedical.com/img/doctor-profile-small.png",
  };


  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search a doctor',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      suggestionsCallback: (pattern) {
        return _doctorNames
            .where((name) => name.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, String doctorName) {
        return ListTile(
          title: Text(doctorName),
        );
      },
      onSuggestionSelected: (String doctorName) {
        _searchController.text = doctorName;
        String? image = _images[doctorName];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorPage(name: doctorName, image: image)
          ),
        );
      },
    );
  }
}
