import 'package:dermo/core/utility/types.dart';

import 'package:dermo/logic/data_objects/entities/user/user.dart';
import 'package:dermo/logic/data_objects/entities/user/user_avatar.dart';
import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/logic/data_objects/value_objects/last_name.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:dermo/logic/data_sources/remote/auth_data_source.dart';
import 'package:dermo/logic/data_sources/remote/db_data_source.dart';
import 'package:dermo/ui/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserManager {
  static const _collectionPath = "users";

  User user = User.guest();
  // injected
  final AuthDataSource _authDataSource;
  final DbDataSource _dbDataSource;

  UserManager({
    required AuthDataSource authDataSource,
    required DbDataSource dbDataSource,
  })  : _authDataSource = authDataSource,
        _dbDataSource = dbDataSource {
    isUSerSignedInStream.listen((isSignedIn) {
      if (isSignedIn) {
        _loadUserFromDb();
      } else {
        user = User.guest();
      }
    });
  }

  Future<void> _loadUserFromDb() async {
    Id? userId = _authDataSource.getCurrentUserId();
    user = await _dbDataSource.read<User>(
        collectionPath: _collectionPath, id: userId);
  }

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
  try {
    Id userId = await _authDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = await _dbDataSource.read<User>(
      collectionPath: _collectionPath, 
      id: userId
    );

    // if (user != null) { 
    //   ref.read(appStatusProvider.notifier).state = AppStatus.loggedIn;
    // }
    
  } catch (e) {
    print("Eroare la autentificare: $e");
  }
}


  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  Future<void> syncUserWithDb() async {
    _dbDataSource.write(collectionPath: _collectionPath, entity: user);
  }

  Stream<bool> get isUSerSignedInStream {
    return _authDataSource.isUserSignedInStream;
  }
}
