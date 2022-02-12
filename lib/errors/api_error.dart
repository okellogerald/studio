class ApiError extends Error {
  ApiError._({required this.message});

  final String message;

  factory ApiError.unknown() =>
      ApiError._(message: 'An unknown error happened. Please try again later.');
}

enum ExceptionType { network, invalid, unknown }
