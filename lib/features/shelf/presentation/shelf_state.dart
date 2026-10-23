import '../../../core/base/base_state.dart';
import '../domain/book.dart';

final class ShelfReady extends BaseState {
  const ShelfReady(this.books);

  final List<Book> books;
}
