import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermo/core/utility/injector.dart';
import 'package:dermo/core/utility/types.dart';
import 'package:dermo/logic/data_objects/entities/common/entity.dart';
import 'package:dermo/logic/data_objects/entities/common/entity_factory.dart';
import 'package:dermo/logic/use_cases/sign_out_use_case.dart';

class DbDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final EntityFactory _entityFactory;

  DbDataSource({required EntityFactory entityFactory})
      : _entityFactory = entityFactory;

  Future<void> write({
    required String collectionPath,
    required Entity entity,
  }) async {
    await _db.collection(collectionPath).doc(entity.id).set(entity.toMap());
  }

  Future<T> read<T>({
    required String collectionPath,
    required Id id,
  }) async {
    DocumentSnapshot documentSnapshot =
        await _db.collection(collectionPath).doc(id).get();

    if (!documentSnapshot.exists) {
      throw Exception('The document does not exist');
    }

    var map = documentSnapshot.data() as Map<String, dynamic>;
    return _entityFactory.createFromMap<T>(map);
  }
}
