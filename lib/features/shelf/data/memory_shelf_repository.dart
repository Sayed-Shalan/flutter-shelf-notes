import 'package:dartz/dartz.dart';

import '../../../core/base/base_repository.dart';
import '../../../core/domain/failure.dart';
import '../../../core/network/app_exception.dart';
import '../domain/book.dart';
import '../domain/shelf_repository.dart';

class MemoryShelfRepository extends BaseRepository implements ShelfRepository {
  MemoryShelfRepository({List<Book>? seed, this.failLoad = false})
    : _books = List<Book>.of(seed ?? const []);

  final List<Book> _books;
  final bool failLoad;
  var _next = 1;

  @override
  Future<Either<Failure, List<Book>>> load() {
    return execute(() async {
      if (failLoad) {
        throw const NetworkException();
      }
      return List<Book>.unmodifiable(_books);
    });
  }

  @override
  Future<Either<Failure, Book>> add(BookDraft draft) {
    return execute(() async {
      final title = draft.title.trim();
      final author = draft.author.trim();
      if (title.isEmpty) {
        throw const ValidationException('title');
      }
      if (author.isEmpty) {
        throw const ValidationException('author');
      }
      final book = Book(
        id: 'local-${_next++}',
        title: title,
        author: author,
        status: draft.status,
      );
      _books.insert(0, book);
      return book;
    });
  }
}
