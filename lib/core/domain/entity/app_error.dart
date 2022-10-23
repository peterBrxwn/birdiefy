class AppError {
  String message;
  late String debugError;

  AppError({
    String? debugError,
    this.message = 'Something went wrong.',
  }) {
    this.debugError = debugError ?? message;
  }

  @override
  String toString() => debugError;
}
