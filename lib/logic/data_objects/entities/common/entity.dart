/// Interface (must be implemented by all entities)
abstract class Entity {
  String get id;

  Map<String, dynamic> toMap();

  Entity fromMap(Map<String, dynamic> map);
}
