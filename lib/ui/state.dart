import 'package:dermo/core/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final registerButtonProvider = StateProvider<bool>((ref) {
  return false;
});

final isUserSignedInProvider = StreamProvider<bool>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
});

final isFirstTimeProvider = FutureProvider<bool>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isFirstTime = prefs.getBool('first_time') ?? true;
  if (isFirstTime) {
    prefs.setBool('first_time', false);
  }
  return isFirstTime;
});

final appStateProvider = StateProvider<AppState>((ref) {
  AsyncValue<bool> isFirstTime = ref.watch(isFirstTimeProvider);
  AsyncValue<bool> isUserSignedIn = ref.watch(isUserSignedInProvider);

  if (isFirstTime.maybeWhen(data: (value) => value, orElse: () => false)) {
    return AppState.firstTime;
  }
  if (isUserSignedIn.maybeWhen(data: (value) => value, orElse: () => false)) {
    return AppState.running;
  }
  return AppState.authentication;
});
