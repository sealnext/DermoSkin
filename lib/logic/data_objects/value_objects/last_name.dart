import 'package:dermo/logic/data_objects/value_objects/common/value_object_exception.dart';
import 'package:meta/meta.dart';

@immutable
class LastName {
  static final _lastNameRegex = RegExp(r"^[a-zA-Z\-ăîșțâĂÎȘȚÂ']+$");

  final String value;

  const LastName._({required this.value});

  factory LastName(String text) {
    if (!_isValid(text)) {
      throw const InvalidLastNameException('Invalid name format.');
    }
    return LastName._(value: text);
  }

  static bool _isValid(String name) {
    return _lastNameRegex.hasMatch(name);
  }
}

@immutable
class InvalidLastNameException extends ValueObjectException {
  const InvalidLastNameException(String message): super(message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}