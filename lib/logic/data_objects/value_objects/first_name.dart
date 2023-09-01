import 'package:dermo/logic/data_objects/value_objects/common/value_object_exception.dart';
import 'package:meta/meta.dart';

import 'package:dermo/logic/data_objects/value_objects/common/value_object.dart';

@immutable
class FirstName extends ValueObject<String> {
  static final _firstNameRegex = RegExp(r"^[ a-zA-Z\-ăîșțâĂÎȘȚÂ']+$");

  const FirstName._({required String value}) : super(value: value);

  factory FirstName(String text) {
    if (!_isValid(text)) {
      throw const InvalidFirstNameException("Invalid name format.");
    }
    return FirstName._(value: text);
  }

  static bool _isValid(String name) {
    return _firstNameRegex.hasMatch(name);
  }
}

@immutable
class InvalidFirstNameException extends ValueObjectException {
  const InvalidFirstNameException(String message) : super(message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}
