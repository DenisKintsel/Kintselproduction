import 'package:get_it/get_it.dart';
import 'package:test_bool/app/presentation/pages/splash_screen/cubit/splash_screen_cubit.dart';

import 'app/data/datasources/datasources.dart';
import 'app/domain/repositories/repository.dart';
import 'app/domain/usecases/bool/add_bool_usecases.dart';
import 'app/domain/usecases/bool/out_bool_usecases.dart';
import 'package:http/http.dart' as http;

import 'app/presentation/pages/bool_view/cubit/bool_cubit.dart';

var sl = GetIt.instance;

Future<void> initGet() async{
  ///Сплеш-скрин
  sl.registerLazySingleton(() => SplashScreenCubit());

  ///Авторизация
  sl.registerLazySingleton(() => AddBoolUseCases(addBoolRepository: sl()));
  sl.registerLazySingleton(() => OutBoolUseCases(outBoolRepository:sl()));
  sl.registerLazySingleton(() => BoolCubit(outBoolUseCases: sl(),addBoolUseCases: sl()));
  /// регистрация
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<Repository>(() => RegistrationUsersDataSourceImpl(client: sl()));
}