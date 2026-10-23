import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf_notes/app.dart';
import 'package:shelf_notes/core/navigation/app_router.dart';
import 'package:shelf_notes/core/settings/locale_cubit.dart';
import 'package:shelf_notes/features/shelf/data/demo_books.dart';
import 'package:shelf_notes/features/shelf/data/memory_shelf_repository.dart';
import 'package:shelf_notes/features/shelf/presentation/shelf_cubit.dart';

void main() {
  testWidgets('shows the seeded shelf and switches to Arabic', (tester) async {
    final cubit = ShelfCubit(MemoryShelfRepository(seed: demoBooks()));
    await cubit.load();
    final locale = LocaleCubit();
    final router = buildRouter();
    addTearDown(() async {
      router.dispose();
      await cubit.close();
      await locale.close();
    });

    await tester.pumpWidget(
      ShelfApp(shelfCubit: cubit, localeCubit: locale, router: router),
    );
    await tester.pumpAndSettle();

    expect(find.text('Paper Cities'), findsOneWidget);
    expect(find.text('Reading'), findsOneWidget);

    await tester.tap(find.byKey(const Key('language-toggle')));
    await tester.pumpAndSettle();

    expect(find.text('أقرأ الآن'), findsOneWidget);
  });
}
