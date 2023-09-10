bool isEmailValid(String email) {
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegex.hasMatch(email);
}

bool isFirstNameValid(String firstName) {
  final firstNameRegex = RegExp(r"^[ a-zA-Z\-ăîșțâĂÎȘȚÂ']+$");
  return firstNameRegex.hasMatch(firstName);
}

bool isLastNameValid(String lastName) {
  final lastNameRegex = RegExp(r"^[a-zA-Z\-ăîșțâĂÎȘȚÂ']+$");
  return lastNameRegex.hasMatch(lastName);
}

bool isPasswordValid(String password) {
  final passwordRegex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$");
  return passwordRegex.hasMatch(password);
}
