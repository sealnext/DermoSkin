import 'package:dermo/logic/data_objects/value_objects/common/value_object_exception.dart';
import 'package:meta/meta.dart';
import 'package:dermo/logic/data_objects/value_objects/common/value_object.dart';

@immutable
class DateOfBirth extends ValueObject<String> {
  static final _dateOfBirthRegex = RegExp(r"^$");

  const DateOfBirth._({required String value}) : super(value: value);

  factory DateOfBirth(String text) {
    if (!_isValid(text)) {
      throw const InvalidDateOfBirthException("Invalid email format");
    }
    return DateOfBirth._(value: text);
  }

  static bool _isValid(String email) {
    return _dateOfBirthRegex.hasMatch(email);
  }
}

@immutable
class InvalidDateOfBirthException extends ValueObjectException {
  const InvalidDateOfBirthException(String message): super(message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}
