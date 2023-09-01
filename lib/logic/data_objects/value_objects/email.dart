import 'package:dermo/logic/data_objects/value_objects/common/value_object_exception.dart';
import 'package:meta/meta.dart';
import 'package:dermo/logic/data_objects/value_objects/common/value_object.dart';

@immutable
class Email extends ValueObject<String> {
  static final _emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  const Email._({required String value}) : super(value: value);

  factory Email(String text) {
    if (!_isValid(text)) {
      throw const InvalidEmailException("Invalid email format");
    }
    return Email._(value: text);
  }

  static bool _isValid(String email) {
    return _emailRegex.hasMatch(email);
  }
}

@immutable
class InvalidEmailException extends ValueObjectException {
  const InvalidEmailException(String message): super(message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}
