import 'package:flutter_test/flutter_test.dart';
import 'package:shelf_notes/core/base/base_state.dart';
import 'package:shelf_notes/features/shelf/data/memory_shelf_repository.dart';
import 'package:shelf_notes/features/shelf/domain/book.dart';
import 'package:shelf_notes/features/shelf/presentation/shelf_cubit.dart';
import 'package:shelf_notes/features/shelf/presentation/shelf_state.dart';

void main() {
  test('load emits an empty shelf', () async {
    final cubit = ShelfCubit(MemoryShelfRepository());
    await cubit.load();
    expect(cubit.state, isA<EmptyState>());
    await cubit.close();
  });

  test('add places the new book first', () async {
    final cubit = ShelfCubit(MemoryShelfRepository());
    await cubit.load();
    final book = await cubit.add(
      const BookDraft(
        title: 'Night Trains',
        author: 'Yusuf Nabil',
        status: BookStatus.queued,
      ),
    );
    final state = cubit.state as ShelfReady;
    expect(book?.title, 'Night Trains');
    expect(state.books.single.title, 'Night Trains');
    await cubit.close();
  });

  test('a repository failure becomes an error state', () async {
    final cubit = ShelfCubit(MemoryShelfRepository(failLoad: true));
    await cubit.load();
    expect(cubit.state, isA<ErrorState>());
    await cubit.close();
  });
}
