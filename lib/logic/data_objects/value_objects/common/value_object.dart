import 'package:meta/meta.dart';

@immutable
class ValueObject<T> {
  final T value;

  const ValueObject({required this.value});
}