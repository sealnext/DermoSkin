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
    'John Doe',
    'Jane Doe',
    'Emily Smith',
  ];

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
      },
    );
  }
}
