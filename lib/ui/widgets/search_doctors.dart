import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/doctor_data.dart';

class SearchDoctor extends StatefulWidget {
  const SearchDoctor({super.key});

  @override
  _SearchDoctorState createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DoctorData>> _getDoctorSuggestions(String query) async {
    final doctorsSnapshot = await _firestore
        .collection('doctors')
        .where('fullName', isGreaterThanOrEqualTo: query)
        .limit(3)
        .get();

    return doctorsSnapshot.docs
        .map((doc) => DoctorData.fromDocument(doc))
        .toList();
  }

  String toTitleCase(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.split(' ').map((word) {
      if (word.isNotEmpty) {
        final firstLetter = word[0].toUpperCase();
        final remaining = word.substring(1).toLowerCase();
        return '$firstLetter$remaining';
      }
      return word;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<DoctorData>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _searchController,
        decoration: const InputDecoration(
          labelText: 'Caută doctor',
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await _getDoctorSuggestions(pattern);
      },
      itemBuilder: (context, DoctorData doctor) {
        return ListTile(
          title: Text(toTitleCase(doctor.fullName)),
          //alte atribute ale doctorului sa se afiseze
        );
      },
      onSuggestionSelected: (DoctorData doctor) {
        _searchController.text = toTitleCase(doctor.fullName);
        // cand selectezi doctorul
      },
    );
  }
}
