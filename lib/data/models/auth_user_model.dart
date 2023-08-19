import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:dermo/domain/entities/auth_user.dart';

class AuthUserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? photoURL;

  const AuthUserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoURL,
  });

  factory AuthUserModel.fromFirebaseAuthUser(
      firebase_auth.User firebaseUser,
      ) {
    return AuthUserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? 'Guest',
      photoURL: firebaseUser.photoURL,
    );
  }

  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      name: name,
      photoURL: photoURL,
    );
  }

  @override
  List<Object?> get props => [id, email, name, photoURL];
}