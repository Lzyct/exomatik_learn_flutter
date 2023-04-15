import 'package:get_it/get_it.dart';

import '../features/auth/auth.dart';
import 'core.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async {
  if (isUnitTest) {
    /// DO something
  } else {
    sl.registerSingleton<DioClient>(DioClient());
    repositories();
    dataSources();
    useCase();
    cubits();
  }
}

void repositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}

void dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
}

void useCase() {
  sl.registerLazySingleton(() => PostLogin(sl()));
}

void cubits() {
  sl.registerFactory(() => LoginCubit(sl()));
}
