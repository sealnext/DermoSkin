import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/doctor_data.dart';

class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'docotrs'; // numele colecției în Firestore

  // Obtine datele doctorului dupa nume
  Future<DoctorData> getDoctorDataByName(String name) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionName)
          .where("fullName", isEqualTo: name)
          .get();

      // Dacă am găsit cel puțin un document cu acest nume, returnăm primul
      if (querySnapshot.docs.isNotEmpty) {
        return DoctorData.fromDocument(querySnapshot.docs.first);
      } else {
        return DoctorData.empty();
      }
    } catch (e) {
      print("Error fetching doctor data by name: $e");
      return DoctorData.empty();
    }
  }

  // Obține datele doctorului după UID
  Future<DoctorData> getDoctorDataByUID(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection(_collectionName).doc(uid).get();

      if (userDoc.exists) {
        return DoctorData.fromDocument(userDoc);
      } else {
        return DoctorData.empty();
      }
    } catch (e) {
      print("Error fetching doctor data: $e");
      return DoctorData.empty();
    }
  }

  // // Actualizează sau creează datele unui utilizator
  // Future<void> setDoctorData(DoctorData data) async {
  //   try {
  //     await _firestore.collection(_collectionName).doc(data.uid).update({
  //       'fullname': data.name,
  //       'address': data.address,
  //       'gender': data.gender,
  //       'dateOfBirth': data.dateOfBirth
  //       // Adaugă și alte câmpuri dacă este necesar
  //     });
  //   } catch (e) {
  //     print("Error setting user data: $e");
  //   }
  // }
}
