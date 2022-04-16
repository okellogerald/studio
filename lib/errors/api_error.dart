class ApiError extends Error {
  ApiError({required this.message});

  final String message;

  factory ApiError.unknown() =>
      ApiError(message: 'An unknown error happened. Please try again later.');

  factory ApiError.timeout() =>
      ApiError(message: 'Connection timed out. Please try again later');

  factory ApiError.internet() =>
      ApiError(message: 'You seem to have no internet connection.');

  factory ApiError.invalid() =>
      ApiError(message: 'Either password or email is invalid.');

  factory ApiError.expiredToken() => ApiError(message: 'Token');

  factory ApiError.firebaseAuth(String? message) =>
      ApiError(message: message ?? 'An error happened during authentication');
}
