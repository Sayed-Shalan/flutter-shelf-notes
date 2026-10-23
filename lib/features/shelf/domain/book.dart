enum BookStatus { reading, queued, finished }

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
  });

  final String id;
  final String title;
  final String author;
  final BookStatus status;
}

class BookDraft {
  const BookDraft({
    required this.title,
    required this.author,
    required this.status,
  });

  final String title;
  final String author;
  final BookStatus status;
}
