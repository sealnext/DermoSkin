import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorData {
  String uid = "";
  String fullName = "";
  String profession = "";
  int patients = 0;
  int experience = 0;
  int reviews = 0;
  String about = "";

  DoctorData({
    required this.uid,
    required this.fullName,
    required this.profession,
    required this.patients,
    required this.experience,
    required this.reviews,
    required this.about,
  });

  DoctorData.empty() {
    uid = "";
    fullName = "";
    profession = "";
    patients = 0;
    experience = 0;
    reviews = 0;
    about = "";
  }

  factory DoctorData.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic>? docData = doc.data() as Map<String, dynamic>?;

    int? safeIntParse(dynamic value) {
      if (value is String) {
        return int.tryParse(value);
      } else if (value is int) {
        return value;
      }
      return null;
    }

    return DoctorData(
      uid: doc.id,
      fullName: (docData?['fullName'] as String?) ?? "",
      profession: (docData?['profession'] as String?) ?? "",
      patients: safeIntParse(docData?['patients']) ?? 0,
      experience: safeIntParse(docData?['experience']) ?? 0,
      reviews: safeIntParse(docData?['reviews']) ?? 0,
      about: (docData?['about'] as String?) ?? "",
      // Similar for other fields
    );
  }
}
