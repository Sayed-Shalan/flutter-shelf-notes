import 'package:dartz/dartz.dart';

import '../../../core/domain/failure.dart';
import 'book.dart';

abstract class ShelfRepository {
  Future<Either<Failure, List<Book>>> load();

  Future<Either<Failure, Book>> add(BookDraft draft);
}
