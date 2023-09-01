import 'package:auto_route/auto_route.dart';

import 'package:dermo/core/utility/types.dart';

import 'package:dermo/logic/data_objects/entities/user/user.dart';
import 'package:dermo/logic/data_objects/entities/user/user_avatar.dart';
import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/logic/data_objects/value_objects/last_name.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:dermo/logic/data_objects/value_objects/url.dart';
import 'package:dermo/logic/data_sources/remote/auth_data_source.dart';
import 'package:dermo/logic/data_sources/remote/db_data_source.dart';

class UserManager {
  static const _collectionPath = "users";

  final AuthDataSource _authDataSource;
  final DbDataSource _dbDataSource;
  User user = User.guest();

  UserManager({
    required AuthDataSource authDataSource,
    required DbDataSource dbDataSource,
  })  : _authDataSource = authDataSource,
        _dbDataSource = dbDataSource;

  /// Used when signing up
  void initializeUser({
    required Id id,
    required Email email,
    required FirstName firstName,
    required LastName lastName,
    UserAvatar? avatar,
  }) {
    user = User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }

  Future<Id> signUp({
    required Email email,
    required Password password,
  }) async {
    return await _authDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn({
    required Email email,
    required Password password,
  }) async {
    Id userId = await _authDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = await _dbDataSource.read<User>(
        collectionPath: _collectionPath, id: userId);
  }

  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  Future<void> syncUserWithDb() async {
    _dbDataSource.write(collectionPath: _collectionPath, entity: user);
  }

  bool isUSerSignedIn() {
    return _authDataSource.isUserSignedIn();
  }
}
