import 'package:dermo/core/utility/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

@riverpod
Stream<bool> isUserSignedIn(IsUserSignedInRef ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
}

@riverpod
Future<bool> isFirstTime(IsFirstTimeRef ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isFirstTime = prefs.getBool('first_time') ?? true;
  if (isFirstTime) {
    prefs.setBool('first_time', false);
  }
  return isFirstTime;
}

@riverpod
class AppState extends _$AppState {
  @override
  AppStatus build() {
    AsyncValue<bool> isFirstTime = ref.watch(isFirstTimeProvider);
    AsyncValue<bool> isUserSignedIn = ref.watch(isUserSignedInProvider);

    if (isFirstTime.maybeWhen(data: (value) => value, orElse: () => false)) {
      return AppStatus.firstTime;
    }
    if (isUserSignedIn.maybeWhen(data: (value) => value, orElse: () => false)) {
      return AppStatus.running;
    }
    return AppStatus.authentication;
  }
}