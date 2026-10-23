import '../../../core/base/base_cubit.dart';
import '../../../core/base/base_state.dart';
import '../domain/book.dart';
import '../domain/shelf_repository.dart';
import 'shelf_state.dart';

class ShelfCubit extends BaseCubit<BaseState> {
  ShelfCubit(this._repository) : super(const LoadingState());

  final ShelfRepository _repository;

  Future<void> load() async {
    emit(const LoadingState());
    final either = await runRequest(request: _repository.load);
    either.fold((_) {}, (books) {
      emit(books.isEmpty ? const EmptyState() : ShelfReady(books));
    });
  }

  Future<Book?> add(BookDraft draft) async {
    final either = await runRequest(
      request: () => _repository.add(draft),
      showError: false,
    );
    return either.fold((_) => null, (book) {
      final current = state;
      final books = current is ShelfReady ? [book, ...current.books] : [book];
      emit(ShelfReady(books));
      return book;
    });
  }
}
