import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_data.dart';

/// `UserService` este o clasă de serviciu dedicată gestionării interacțiunilor
/// cu colecția de utilizatori din Firestore.
///
/// Această clasă furnizează metode pentru a prelua și actualiza datele utilizatorilor
/// din baza de date Firestore. În interior, ea folosește modelul `UserData` pentru
/// a reprezenta structura datelor.
///
/// Metodele principale ale acestei clase sunt:
/// - `getUserDataByUID(String uid)`: Această metodă returnează datele unui utilizator
///   în funcție de UID-ul său. Dacă utilizatorul cu UID-ul specificat nu este găsit,
///   se va returna un obiect `UserData` cu valorile inițializate la valorile implicite.
///
/// - `setUserData(UserData data)`: Această metodă creează sau actualizează datele unui
///   utilizator în baza de date. Ea folosește UID-ul din obiectul `UserData` pentru
///   a determina înregistrarea corectă de actualizat sau creat.
///
/// Pentru a folosi această clasă, instanțiază un obiect `UserService` și apoi folosește
/// metodele sale pentru a interacționa cu baza de date.
///
/// Exemplu de utilizare:
///
/// ```dart
/// UserService userService = UserService();
/// UserData userData = await userService.getUserDataByUID('some-uid');
/// print(userData.name); // va afișa numele utilizatorului sau `""` dacă nu există
/// ```

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users'; // numele colecției în Firestore

  // Obține datele unui utilizator după UID
  Future<UserData> getUserDataByUID(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection(_collectionName).doc(uid).get();

      if (userDoc.exists) {
        return UserData.fromDocument(userDoc);
      } else {
        return UserData.empty();
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return UserData.empty();
    }
  }

  // Actualizează sau creează datele unui utilizator
  Future<void> setUserData(UserData data) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateDisplayName(data.name);
        await user.reload();
      }

      await _firestore.collection(_collectionName).doc(data.uid).update({
        'name': data.name,
        'address': data.address,
        'gender': data.gender,
        'dateOfBirth': data.dateOfBirth
        // Adaugă și alte câmpuri dacă este necesar
      });
    } catch (e) {
      print("Error setting user data: $e");
    }
  }
}
