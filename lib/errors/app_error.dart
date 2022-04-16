class AppError {
  final String message;
  final bool isShownViaSnackBar;

  AppError._(this.message, [this.isShownViaSnackBar = true]);

  factory AppError.onBody(String message) => AppError._(message, false);
  factory AppError(String message) => AppError._(message);

  bool get isVideoNotFound => message == 'Video not found';
}
