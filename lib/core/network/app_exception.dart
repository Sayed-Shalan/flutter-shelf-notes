class NetworkException implements Exception {
  const NetworkException();
}

class NotFoundException implements Exception {
  const NotFoundException();
}

class ValidationException implements Exception {
  const ValidationException(this.field);
  final String field;
}
