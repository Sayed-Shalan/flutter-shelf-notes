import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/di/injector.dart';
import 'core/navigation/app_router.dart';
import 'core/settings/locale_cubit.dart';
import 'features/shelf/presentation/shelf_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final shelfCubit = getIt<ShelfCubit>();
  runApp(
    ShelfApp(
      shelfCubit: shelfCubit,
      localeCubit: getIt<LocaleCubit>(),
      router: buildRouter(),
    ),
  );
}
