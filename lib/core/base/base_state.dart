import '../domain/failure.dart';

abstract class BaseState {
  const BaseState();
}

final class LoadingState extends BaseState {
  const LoadingState();
}

final class EmptyState extends BaseState {
  const EmptyState();
}

final class ErrorState extends BaseState {
  const ErrorState(this.failure);
  final Failure failure;
}
