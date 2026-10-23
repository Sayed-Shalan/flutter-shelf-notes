import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/settings/locale_cubit.dart';
import 'features/shelf/presentation/shelf_cubit.dart';
import 'l10n/app_localizations.dart';

class ShelfApp extends StatelessWidget {
  const ShelfApp({
    required this.shelfCubit,
    required this.localeCubit,
    required this.router,
    super.key,
  });

  final ShelfCubit shelfCubit;
  final LocaleCubit localeCubit;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: shelfCubit),
        BlocProvider.value(value: localeCubit),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF8C3A2F),
                surface: const Color(0xFFF6F1E7),
              ),
              scaffoldBackgroundColor: const Color(0xFFF6F1E7),
              useMaterial3: true,
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
