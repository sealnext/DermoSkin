import 'package:dermo/logic/data_objects/entities/user/user.dart';

class EntityFactory {
  /// Every time a new entity class is added you have to update createFromMap()
  T createFromMap<T>(Map<String, dynamic> map) {
    if (T == User) {
      return User.fromMap(map) as T;
    }
    throw Exception("Type not supported: ${T.toString()}");
  }
}
