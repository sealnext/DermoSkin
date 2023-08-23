import 'package:dermo/core/utility/types.dart';
import 'package:dermo/logic/data_objects/entities/common/base_entity.dart';
import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/logic/data_objects/value_objects/last_name.dart';
import 'package:dermo/logic/data_objects/value_objects/url.dart';

class User extends BaseEntity {
  static const _randomAvatarUrl = "https://i.pravatar.cc/300";

  Email email;
  FirstName firstName;
  LastName lastName;
  Url photoUrl;

  User({
    required Id id,
    required this.email,
    required this.firstName,
    required this.lastName,
    Url? photoUrl,
  })  : photoUrl = photoUrl ?? Url(_randomAvatarUrl),
        super(id: id);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      email: Email(map["email"]),
      firstName: FirstName(map["firstName"]),
      lastName: LastName(map["lastName"]),
      photoUrl: Url(map["photoUrl"]),
    );
  }

  @override
  User fromMap(Map<String, dynamic> map) {
    return User.fromMap(map);
  }

  @override
  Map<String, String> toMap() {
    return {
      'id': id,
      'email': email.value,
      'firstName': firstName.value,
      'lastName': lastName.value,
      'photoUrl': photoUrl.value,
    };
  }
}
