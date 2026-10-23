import 'package:dartz/dartz.dart';

import '../domain/error_mapper.dart';
import '../domain/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> execute<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } catch (error) {
      return Left(mapException(error));
    }
  }
}
