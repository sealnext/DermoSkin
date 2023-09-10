import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_logic.freezed.dart';

part 'user_logic.g.dart';

@freezed
class MyUser with _$MyUser {
  const factory MyUser({
    required String firstName,
    required String lastName,
    required String email,
    required String avatar,
  }) = _MyUser;

  factory MyUser.empty() =>
      const MyUser(firstName: 'Offline', lastName: '', email: '', avatar: '');

  factory MyUser.fromJson(Map<String, Object?> json) => _$MyUserFromJson(json);
}

@riverpod
class UpdateUser extends _$UpdateUser {
  @override
  Future<void> build() async {}

  Future<void> updateUser(MyUser newUser) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(newUser.toJson()));
  }
}

@riverpod
Stream<bool> isUserSignedIn(IsUserSignedInRef ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
}

@riverpod
Stream<Map<String, dynamic>?> userJson(UserJsonRef ref) {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const Stream.empty();
  }
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .snapshots()
      .map((doc) => doc.data());
}

@riverpod
MyUser user(UserRef ref) {
  AsyncValue<Map?> userJsonMap = ref.watch(userJsonProvider);
  if (userJsonMap.maybeWhen(data: (map) => map == null, orElse: () => true)) {
    return MyUser.empty();
  }
  MyUser user = MyUser.fromJson(userJsonMap.value as Map<String, Object?>);
  return user;
}

// @riverpod
// Future<void> updateUser(UpdateUserRef ref, MyUser newUser) {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     return Future.error("User is offline");
//   }
//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(user.uid)
//       .update(newUser.toJson());
// }
