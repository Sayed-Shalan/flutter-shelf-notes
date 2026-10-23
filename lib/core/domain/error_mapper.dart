import '../network/app_exception.dart';
import 'failure.dart';

Failure mapException(Object error) {
  return switch (error) {
    NetworkException() => const NetworkFailure(),
    NotFoundException() => const NotFoundFailure(),
    ValidationException(:final field) => ValidationFailure(field),
    _ => const UnexpectedFailure(),
  };
}
