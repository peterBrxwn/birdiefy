class FiberError {
  String message;
  late String debugError;

  FiberError({
    String? debugError,
    this.message = 'Something went wrong.',
  }) {
    this.debugError = debugError ?? message;
  }

  @override
  String toString() => debugError;
}
