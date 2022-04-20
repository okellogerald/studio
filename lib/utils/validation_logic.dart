String? checkIfPasswordsMatch(String password, String confirmationPassword) {
  if (password != confirmationPassword) return 'Passwords do not match';
  return null;
}

String? validateText(String? value, String errorId) {
  if (value == null || value.trim().isEmpty) {
    return '$errorId can\'t be empty';
  } else {
    return null;
  }
}

String? validateNumber(String? value, String errorId) {
  if (value == null || value.isEmpty) {
    return '$errorId cannot be empty.';
  } else if (double.tryParse(value) == null) {
    return 'Invalid value for $errorId!';
  } else if (double.tryParse(value) == 0) {
    return '$errorId can\'t be zero.';
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  if (email == null || email.trim().isEmpty) return 'Email can\'t be empty';
  final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+\.[a-zA-Z]+");
  final isValidEmail = regex.hasMatch(email);
  if (!isValidEmail) return 'Invalid Email';
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.trim().isEmpty) {
    return 'Password can\'t be empty';
  }
  if (password.length < 8) {
    return 'Password should contain at least 8 characters';
  }
  return null;
}

String? validatePasswords(String? password, String? confirmationPassword) {
  final passwordError = validatePassword(password);
  if (passwordError != null) return null;
  if (password != confirmationPassword) return 'Passwords do not match';
  return null;
}

///returns true if their is no errors.
bool checkErrors(Map<String, String?> errors) {
  final errorsList = errors.values.toList();
  errorsList.removeWhere((e) => e == null);
  return errorsList.isNotEmpty;
}
