// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'الرف';

  @override
  String get shelfTitle => 'رف القراءة';

  @override
  String get emptyShelf => 'الرف فارغ.';

  @override
  String get loadFailed => 'تعذر تحميل الرف.';

  @override
  String get retry => 'حاول مرة أخرى';

  @override
  String get addBook => 'أضف كتابًا';

  @override
  String get titleLabel => 'العنوان';

  @override
  String get authorLabel => 'المؤلف';

  @override
  String get save => 'حفظ';

  @override
  String get titleRequired => 'أضف عنوانًا.';

  @override
  String get authorRequired => 'أضف مؤلفًا.';

  @override
  String get statusReading => 'أقرأ الآن';

  @override
  String get statusQueued => 'في الانتظار';

  @override
  String get statusFinished => 'انتهيت';

  @override
  String get language => 'اللغة';
}
