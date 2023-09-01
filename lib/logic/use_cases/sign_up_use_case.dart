import 'package:dermo/core/utility/types.dart';
import 'package:dermo/logic/data_objects/value_objects/date_of_birth.dart';
import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/first_name.dart';
import 'package:dermo/logic/data_objects/value_objects/last_name.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:dermo/logic/managers/user_manager.dart';

class SignUpUseCase {
  final UserManager userManager;

  SignUpUseCase({required this.userManager});

  Future<void> call({
    required FirstName firstName,
    required LastName lastName,
    required Email email,
    required Password password,
  }) async {
    Id userId = await userManager.signUp(
      email: email,
      password: password,
    );
    userManager.initializeUser(id: userId, email: email, firstName: firstName, lastName: lastName);
    userManager.syncUserWithDb();
  }
}
