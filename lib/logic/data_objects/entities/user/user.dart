import 'package:dermo/core/utility/types.dart';
import 'package:dermo/logic/data_objects/entities/common/base_entity.dart';
import 'package:dermo/logic/data_objects/entities/user/user_avatar.dart';
import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/logic/data_objects/value_objects/last_name.dart';

class User extends BaseEntity {
  final Email email;
  final FirstName firstName;
  final LastName lastName;
  final UserAvatar avatar;

  User({
    required Id id,
    required this.email,
    required this.firstName,
    required this.lastName,
    UserAvatar? avatar,
  })  : avatar = avatar ?? UserAvatar(),
        super(id: id);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      email: Email(map["email"]),
      firstName: FirstName(map["firstName"]),
      lastName: LastName(map["lastName"]),
      avatar: UserAvatar(map["avatar"]),
    );
  }

  factory User.guest() {
    return User(
      id: "",
      email: Email("support@sealnext.com"),
      firstName: FirstName("Guest"),
      lastName: LastName("Guest"),
      avatar: UserAvatar(), // Calea locală către avatarul implicit
    );
  }

  @override
  User fromMap(Map<String, dynamic> map) {
    return User.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email.value,
      'firstName': firstName.value,
      'lastName': lastName.value,
      'avatar': avatar.image,
    };
  }
}
