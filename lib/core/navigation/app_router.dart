import 'package:go_router/go_router.dart';

import '../../features/shelf/presentation/add_book_page.dart';
import '../../features/shelf/presentation/book_page.dart';
import '../../features/shelf/presentation/shelf_page.dart';

GoRouter buildRouter() {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const ShelfPage()),
      GoRoute(path: '/books/new', builder: (_, _) => const AddBookPage()),
      GoRoute(
        path: '/books/:id',
        builder: (_, state) => BookPage(id: state.pathParameters['id']!),
      ),
    ],
  );
}
