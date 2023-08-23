import 'package:meta/meta.dart';

@immutable
class ValueObjectException implements Exception {
  final String message;

  const ValueObjectException(this.message);
}