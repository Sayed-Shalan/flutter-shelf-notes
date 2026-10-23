import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base_state.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/book.dart';
import 'shelf_cubit.dart';
import 'shelf_state.dart';

class BookPage extends StatelessWidget {
  const BookPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: BlocBuilder<ShelfCubit, BaseState>(
        builder: (context, state) {
          if (state is! ShelfReady) {
            return const Center(child: CircularProgressIndicator());
          }
          final matches = state.books.where((book) => book.id == id);
          if (matches.isEmpty) {
            return Center(child: Text(l10n.loadFailed));
          }
          final book = matches.first;
          final status = switch (book.status) {
            BookStatus.reading => l10n.statusReading,
            BookStatus.queued => l10n.statusQueued,
            BookStatus.finished => l10n.statusFinished,
          };
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  book.author,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(status),
              ],
            ),
          );
        },
      ),
    );
  }
}
