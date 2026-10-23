import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/base_state.dart';
import '../../../core/settings/locale_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/book.dart';
import 'shelf_cubit.dart';
import 'shelf_state.dart';

class ShelfPage extends StatefulWidget {
  const ShelfPage({super.key});

  @override
  State<ShelfPage> createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> {
  @override
  void initState() {
    super.initState();
    final state = context.read<ShelfCubit>().state;
    if (state is LoadingState) {
      context.read<ShelfCubit>().load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shelfTitle),
        actions: [
          IconButton(
            key: const Key('language-toggle'),
            tooltip: l10n.language,
            onPressed: context.read<LocaleCubit>().toggle,
            icon: const Icon(Icons.translate),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('add-book'),
        onPressed: () => context.push('/books/new'),
        icon: const Icon(Icons.add),
        label: Text(l10n.addBook),
      ),
      body: BlocBuilder<ShelfCubit, BaseState>(
        builder: (context, state) {
          return switch (state) {
            LoadingState() => const Center(
              key: Key('shelf-loading'),
              child: CircularProgressIndicator(),
            ),
            EmptyState() => Center(
              key: const Key('shelf-empty'),
              child: Text(l10n.emptyShelf),
            ),
            ErrorState() => Center(
              key: const Key('shelf-error'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.loadFailed),
                  const SizedBox(height: 12),
                  FilledButton(
                    key: const Key('shelf-retry'),
                    onPressed: context.read<ShelfCubit>().load,
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),
            ShelfReady(:final books) => ListView.separated(
              key: const Key('shelf-list'),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              itemCount: books.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final book = books[index];
                return _BookTile(book: book);
              },
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = switch (book.status) {
      BookStatus.reading => l10n.statusReading,
      BookStatus.queued => l10n.statusQueued,
      BookStatus.finished => l10n.statusFinished,
    };
    return Card(
      key: Key('book-tile-${book.id}'),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: Text(status),
        onTap: () => context.push('/books/${book.id}'),
      ),
    );
  }
}
