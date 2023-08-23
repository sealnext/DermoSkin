import 'package:dermo/core/utility/types.dart';
import 'package:dermo/logic/data_objects/entities/common/entity.dart';

/// Base class (must be extended by all entities)
abstract class BaseEntity implements Entity {
  final Id _id;

  const BaseEntity({required Id id}) : _id = id;

  @override
  Id get id => _id;
}