import 'package:cloud_firestore/cloud_firestore.dart';

/// `UserData` este o clasă model care reprezintă structura datelor unui utilizator
/// din baza de date Firestore.
///
/// Această clasă conține informații precum `uid`, `name`, `address` și `gender`
/// și poate fi extinsă pentru a include și alte atribute, dacă este necesar.
///
/// Metodele principale ale acestei clase sunt:
/// - `UserData.fromDocument(DocumentSnapshot doc)`: Acesta este un constructor de tip factory
///   care transformă un `DocumentSnapshot` din Firestore într-un obiect `UserData`.
///   Dacă un anumit câmp nu există în document, valoarea pentru acel câmp va fi `null`.
///
/// - `UserData.empty()`: Acesta este un constructor care creează un obiect `UserData` cu
///   toate câmpurile inițializate la valoarea implicită (`""` sau valoarea de tip gol).
///
/// Pentru a folosi această clasă, poți crea un obiect nou de tip `UserData` fie direct
/// prin constructorul principal (specificând toate valorile), fie prin unul dintre
/// constructorii menționați mai sus.
///
/// Exemplu de utilizare:
///
/// ```dart
/// DocumentSnapshot doc = ...; // obține un document din Firestore
/// UserData userData = UserData.fromDocument(doc);
/// print(userData.name); // va afișa numele utilizatorului sau `null` dacă nu există
/// ```

class UserData {
  String uid = "";
  String name = "";
  String address = "";
  String gender = "";
  String dateOfBirth = "";
  // Poți adăuga și alte câmpuri dacă este necesar

  UserData(
      {required this.uid,
      required this.name,
      required this.address,
      required this.gender,
      required this.dateOfBirth});

  UserData.empty() {
    uid = "";
    name = "";
    address = "";
    gender = "";
    dateOfBirth = "";
  }

  factory UserData.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic>? docData = doc.data() as Map<String, dynamic>?;
    return UserData(
      uid: doc.id,
      name: (docData?['name'] as String?) ?? "",
      address: (docData?['address'] as String?) ?? "",
      gender: (docData?['gender'] as String?) ?? "",
      dateOfBirth: (docData?['dateOfBirth'] as String?) ?? "",
      // Similar pentru alte câmpuri
    );
  }
}
