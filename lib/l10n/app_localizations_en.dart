// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shelf';

  @override
  String get shelfTitle => 'Reading shelf';

  @override
  String get emptyShelf => 'The shelf is empty.';

  @override
  String get loadFailed => 'The shelf could not be loaded.';

  @override
  String get retry => 'Try again';

  @override
  String get addBook => 'Add a book';

  @override
  String get titleLabel => 'Title';

  @override
  String get authorLabel => 'Author';

  @override
  String get save => 'Save';

  @override
  String get titleRequired => 'Add a title.';

  @override
  String get authorRequired => 'Add an author.';

  @override
  String get statusReading => 'Reading';

  @override
  String get statusQueued => 'Queued';

  @override
  String get statusFinished => 'Finished';

  @override
  String get language => 'Language';
}
