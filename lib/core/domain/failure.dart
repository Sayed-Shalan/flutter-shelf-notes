sealed class Failure {
  const Failure();
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

final class ValidationFailure extends Failure {
  const ValidationFailure(this.field);
  final String field;
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}
