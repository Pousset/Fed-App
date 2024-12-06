class LoginError implements Exception {
  const LoginError({required this.title, required this.message});

  final String title;
  final String message;

  @override
  String toString() {
    return 'title: $title, message: $message';
  }
}
