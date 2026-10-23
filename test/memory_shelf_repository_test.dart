import 'package:flutter_test/flutter_test.dart';
import 'package:shelf_notes/core/domain/failure.dart';
import 'package:shelf_notes/features/shelf/data/memory_shelf_repository.dart';
import 'package:shelf_notes/features/shelf/domain/book.dart';

void main() {
  test('load returns the seed and add rejects a blank title', () async {
    final repository = MemoryShelfRepository(
      seed: const [
        Book(
          id: 'one',
          title: 'Paper Cities',
          author: 'Hana Mostafa',
          status: BookStatus.reading,
        ),
      ],
    );

    final loaded = await repository.load();
    expect(
      loaded.fold((_) => null, (books) => books.single.title),
      'Paper Cities',
    );

    final added = await repository.add(
      const BookDraft(title: '  ', author: 'Yusuf', status: BookStatus.queued),
    );
    expect(
      added.fold((failure) => failure, (_) => null),
      isA<ValidationFailure>(),
    );
  });

  test('a failed load becomes a network failure', () async {
    final repository = MemoryShelfRepository(failLoad: true);
    final result = await repository.load();
    expect(
      result.fold((failure) => failure, (_) => null),
      isA<NetworkFailure>(),
    );
  });
}
