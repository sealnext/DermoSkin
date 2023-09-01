import 'package:dermo/logic/data_objects/value_objects/common/value_object_exception.dart';
import 'package:meta/meta.dart';

@immutable
class Password {
  static final _passwordRegex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$");

  final String value;

  const Password._({required this.value});

  factory Password(String text) {
    if (!_isValid(text)) {
      throw const InvalidPasswordException("Invalid password format.");
    }
    return Password._(value: text);
  }

  static bool _isValid(String password) {
    return _passwordRegex.hasMatch(password);
  }
}

@immutable
class InvalidPasswordException extends ValueObjectException {
  const InvalidPasswordException(String message) : super(message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}
