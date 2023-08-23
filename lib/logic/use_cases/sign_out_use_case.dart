import 'package:dermo/logic/managers/user_manager.dart';

class SignOutUseCase {
  final UserManager userManager;

  SignOutUseCase({required this.userManager});

  Future<void> call() async {
    await userManager.signOut();
  }
}
