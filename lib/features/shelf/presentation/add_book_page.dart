import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/book.dart';
import 'shelf_cubit.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _title = TextEditingController();
  final _author = TextEditingController();
  String? _titleError;
  String? _authorError;

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final title = _title.text.trim();
    final author = _author.text.trim();
    setState(() {
      _titleError = title.isEmpty ? l10n.titleRequired : null;
      _authorError = author.isEmpty ? l10n.authorRequired : null;
    });
    if (title.isEmpty || author.isEmpty) {
      return;
    }
    final book = await context.read<ShelfCubit>().add(
      BookDraft(title: title, author: author, status: BookStatus.queued),
    );
    if (book != null && mounted) {
      context.go('/books/${book.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addBook)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            key: const Key('book-title'),
            controller: _title,
            decoration: InputDecoration(
              labelText: l10n.titleLabel,
              errorText: _titleError,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('book-author'),
            controller: _author,
            decoration: InputDecoration(
              labelText: l10n.authorLabel,
              errorText: _authorError,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            key: const Key('save-book'),
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
