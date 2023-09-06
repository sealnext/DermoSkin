import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppStatus { loading, firstTime, goToLogin, goToRegister, loggedIn }

final appStatusProvider = StateProvider<AppStatus>((ref) {
  return AppStatus.loading;
});
