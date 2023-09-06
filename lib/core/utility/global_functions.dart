import 'package:shared_preferences/shared_preferences.dart';

import 'package:dermo/core/utility/injector.dart';

class Functions {
  static final _persistentStorage = injector<SharedPreferences>();

  static Future<bool> isFirstTime() async {
    bool isFirstTime = _persistentStorage.getBool('first_time') ?? true;
    if (isFirstTime) {
      await _persistentStorage.setBool('first_time', false);
    }
    return isFirstTime;
  }

}
