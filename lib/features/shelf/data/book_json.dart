import '../domain/book.dart';

Book bookFromJson(Map<String, dynamic> json) {
  return Book(
    id: json['id'] as String,
    title: json['title'] as String,
    author: json['author'] as String,
    status: BookStatus.values.byName(json['status'] as String),
  );
}

Map<String, dynamic> draftToJson(BookDraft draft) {
  return {
    'title': draft.title,
    'author': draft.author,
    'status': draft.status.name,
  };
}
