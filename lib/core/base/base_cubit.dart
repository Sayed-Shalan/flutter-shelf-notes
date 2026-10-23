import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/failure.dart';
import 'base_state.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);

  Future<Either<Failure, T>> runRequest<T>({
    required Future<Either<Failure, T>> Function() request,
    bool showError = true,
  }) async {
    final either = await request();
    if (showError && either.isLeft()) {
      final failure = either.fold((error) => error, (_) => null);
      if (failure != null) {
        emit(ErrorState(failure) as S);
      }
    }
    return either;
  }
}
