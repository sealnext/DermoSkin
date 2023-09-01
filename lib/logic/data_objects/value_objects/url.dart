import 'package:dermo/logic/data_objects/value_objects/common/value_object_exception.dart';
import 'package:flutter/foundation.dart';

@immutable
class Url {
  // https://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url
  static final _urlRegex = RegExp(
      r"^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&/=]*)$");

  final String value;

  const Url._(this.value);

  factory Url(String text) {
    if (!_isValid(text)) {
      throw const InvalidUrlException('Invalid URL format');
    }
    return Url._(text);
  }

  static bool _isValid(String url) {
    return _urlRegex.hasMatch(url);
  }
}

@immutable
class InvalidUrlException extends ValueObjectException {
  const InvalidUrlException(String message) : super(message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}
