// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyUser _$$_MyUserFromJson(Map<String, dynamic> json) => _$_MyUser(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$$_MyUserToJson(_$_MyUser instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'avatar': instance.avatar,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isUserSignedInHash() => r'efeb9933edd891c4ee556d89336d0b320e5c3b6e';

/// See also [isUserSignedIn].
@ProviderFor(isUserSignedIn)
final isUserSignedInProvider = AutoDisposeStreamProvider<bool>.internal(
  isUserSignedIn,
  name: r'isUserSignedInProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUserSignedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsUserSignedInRef = AutoDisposeStreamProviderRef<bool>;
String _$userJsonHash() => r'a8a78144c5c4aba80bd6d6292d4995a952eedc22';

/// See also [userJson].
@ProviderFor(userJson)
final userJsonProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>?>.internal(
  userJson,
  name: r'userJsonProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userJsonHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserJsonRef = AutoDisposeStreamProviderRef<Map<String, dynamic>?>;
String _$userHash() => r'92f96d52a868a2a17a6392e74b4a1f9f552364a3';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeProvider<MyUser>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeProviderRef<MyUser>;
String _$updateUserHash() => r'acd96d9cb7a82328e33c8922b30a5049fe93024c';

/// See also [UpdateUser].
@ProviderFor(UpdateUser)
final updateUserProvider =
    AutoDisposeAsyncNotifierProvider<UpdateUser, void>.internal(
  UpdateUser.new,
  name: r'updateUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateUser = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
