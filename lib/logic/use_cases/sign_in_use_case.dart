import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:dermo/logic/managers/user_manager.dart';

class SignInUseCase {
  final UserManager userManager;

  SignInUseCase({required this.userManager});

  Future<void> call({
    required Email email,
    required Password password,
  }) async {
    await userManager.signIn(
      email: email,
      password: password,
    );
  }
}
