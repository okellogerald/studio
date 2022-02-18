class ApiError extends Error {
  ApiError._({required this.message});

  final String message;

  factory ApiError.unknown() =>
      ApiError._(message: 'An unknown error happened. Please try again later.');

  factory ApiError.timeout() =>
      ApiError._(message: 'Connection timed out. Please try again later');

  factory ApiError.internet() =>
      ApiError._(message: 'You seem to have no internet connection.');

  factory ApiError.invalid() =>
      ApiError._(message: 'Either password or email is invalid.');

  factory ApiError.expiredToken() => ApiError._(message: 'Token');

  factory ApiError.firebaseAuth(String? message) =>
      ApiError._(message: message ?? 'An error happened during authentication');
}
