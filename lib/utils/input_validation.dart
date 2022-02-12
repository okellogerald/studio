class InputValidation {
  static String? validateText(String value, String errorId) {
    if (value.trim().isEmpty) return '$errorId can\'t be empty';
    return null;
  }

  static String? validateNumber(String value, String errorId) {
    if (value.isEmpty) {
      return '$errorId cannot be empty.';
    } else if (double.tryParse(value) == null) {
      return 'Invalid value for $errorId!';
    } else if (double.tryParse(value) == 0) {
      return '$errorId can\'t be zero.';
    }
    return null;
  }

  static String? checkIfPasswordsMatch(
      String password, String confirmationPassword) {
    if (password != confirmationPassword) return 'Passwords do not match';
    return null;
  }

  static bool checkErrors(Map<String, String?> errors) {
    final errorsList = errors.values.toList();
    errorsList.removeWhere((e) => e == null);
    return errorsList.isNotEmpty;
  }
}
