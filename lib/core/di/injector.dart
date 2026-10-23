import 'package:get_it/get_it.dart';

import '../../features/shelf/data/demo_books.dart';
import '../../features/shelf/data/memory_shelf_repository.dart';
import '../../features/shelf/domain/shelf_repository.dart';
import '../../features/shelf/presentation/shelf_cubit.dart';
import '../settings/locale_cubit.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies({ShelfRepository? repository}) {
  if (getIt.isRegistered<ShelfRepository>()) {
    return;
  }
  getIt.registerSingleton<ShelfRepository>(
    repository ?? MemoryShelfRepository(seed: demoBooks()),
  );
  getIt.registerFactory(() => ShelfCubit(getIt<ShelfRepository>()));
  getIt.registerLazySingleton(LocaleCubit.new);
}
