// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../model/doctor_data.dart';
//
// class SearchDoctor extends StatefulWidget {
//   const SearchDoctor({super.key});
//
//   @override
//   _SearchDoctorState createState() => _SearchDoctorState();
// }
//
// class _SearchDoctorState extends State<SearchDoctor> {
//   final TextEditingController _searchController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<List<DoctorData>> _getDoctorSuggestions(String query) async {
//     query = query.toLowerCase();
//     if (query.isEmpty) {
//       return [];
//     }
//
//     final doctorsSnapshot = await _firestore
//         .collection('doctors')
//         .where('fullName', isGreaterThanOrEqualTo: query)
//         .limit(3)
//         .get();
//
//     return doctorsSnapshot.docs
//         .map((doc) => DoctorData.fromDocument(doc))
//         .toList();
//   }
//
//   String toTitleCase(String text) {
//     if (text.isEmpty) {
//       return text;
//     }
//     return text.split(' ').map((word) {
//       if (word.isNotEmpty) {
//         final firstLetter = word[0].toUpperCase();
//         final remaining = word.substring(1).toLowerCase();
//         return '$firstLetter$remaining';
//       }
//       return word;
//     }).join(' ');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<DoctorData>(
//       textFieldConfiguration: TextFieldConfiguration(
//         controller: _searchController,
//         style: DefaultTextStyle.of(context).style.copyWith(
//             fontStyle: FontStyle
//                 .normal), // O necesitate pentru a evita erori legate de stilul textului
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: const Icon(Icons.search),
//           hintText: 'Search a doctor',
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//       suggestionsCallback: (pattern) async {
//         return await _getDoctorSuggestions(pattern);
//       },
//       itemBuilder: (context, DoctorData doctor) {
//         return ListTile(
//           title: Text(toTitleCase(doctor.fullName)),
//           // show everything you want beside the name if u want
//         );
//       },
//       onSuggestionSelected: (DoctorData doctor) {
//         _searchController.text = toTitleCase(doctor.fullName);
//         // when u click on a name form suggestions
//       },
//     );
//   }
// }
