import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dermo/features/user/user_logic.dart';

part 'app_logic.g.dart';

enum AppStatus {
  firstTime,
  authentication,
  running
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
