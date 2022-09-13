import 'package:get_it/get_it.dart';
import 'package:pattern_architecture/app/data/datasources/local/hive_datasources.dart';
import 'package:pattern_architecture/app/domain/usecases/check_hive_user/check_user_account.dart';
import 'package:pattern_architecture/app/presentation/pages/cargo/cubit/cargo_cubit.dart';
import 'package:pattern_architecture/app/presentation/pages/driver_car/cubit/driver_car_cubit.dart';
import 'package:pattern_architecture/app/presentation/pages/orders/cubit/orders_cubit.dart';
import 'package:pattern_architecture/app/presentation/pages/orders1/orders.dart';
import 'package:pattern_architecture/app/presentation/pages/splash_screen/cubit/splash_screen_cubit.dart';

import 'app/data/datasources/registation_users_datasources.dart';
import 'app/domain/repositories/repository.dart';
import 'app/domain/repositories/repository_hive.dart';
import 'app/domain/usecases/ad_output/ad_card_output_usecase.dart';
import 'app/domain/usecases/ad_output/cargo_output.dart';
import 'app/domain/usecases/ad_output/driver_car_output.dart';
import 'app/domain/usecases/add_ad/add_ad_usecases.dart';
import 'app/domain/usecases/add_ad/add_cargo_usecases.dart';
import 'app/domain/usecases/order_status/ad_status_respond_usecases.dart';
import 'app/domain/usecases/user/autorization_user.dart';
import 'app/domain/usecases/user/registration_user.dart';
import 'app/presentation/pages/ad_card/cubit/ad_card_cubit.dart';
import 'app/presentation/pages/add_ad/cubit/add_ad_cubit.dart';
import 'app/presentation/pages/add_cargo/cubit/add_cargo_cubit.dart';
import 'app/presentation/pages/autorization/cubit/autorization_cubit.dart';
import 'app/presentation/pages/registration/cubit/registration_cubit.dart';
import 'package:http/http.dart' as http;

var sl = GetIt.instance;

Future<void> initGet() async{
  ///Вывод раскрытого объявления/
  sl.registerLazySingleton(() => AdStatusRespondUseCases(adStatusRespondRepository: sl()));
  sl.registerLazySingleton(() => AdCardUseCasesUser(adCardOutputRepository: sl()));
  sl.registerLazySingleton(() => AdCardCubit(adCardUseCasesUser: sl(),adStatusRespondUseCases: sl()));
  ///Добавление груза
  sl.registerLazySingleton(() => AddCargoUseCases(addCargoRepository: sl()));
  sl.registerLazySingleton(() => AddCargoCubit(addCargoUseCases: sl()));
  ///Груз
  sl.registerLazySingleton(() => CargoOutPutUseCasesUser(outputCargoRepository: sl()));
  sl.registerLazySingleton(() => CargoCubit(cargoOutPutUseCasesUser: sl()));

  ///Добавление объявления для перевозчиков
  sl.registerLazySingleton(() => AddAdCubit(addAdUseCases: sl()));
  sl.registerLazySingleton(() => AddAdUseCases(addAdRepository :sl()));

  ///Перевозчики
  sl.registerLazySingleton(() => DriverCarCubit(outPutUseCasesUser: sl()));
  sl.registerLazySingleton(() => DriverCarOutPutUseCasesUser(outputDriverCarRepository: sl()));
  ///Заказы
  sl.registerLazySingleton(() => OrdersCubit());

  sl.registerLazySingleton<RepositoryHive>(() => HiveDataSourceImpl());
  sl.registerLazySingleton(() => CheckHiveUseCasesUser(repositoryHive: sl()));

  ///Сплеш-скрин
  sl.registerLazySingleton(() => SplashScreenCubit(checkHiveUseCasesUser: sl()));

  ///Авторизация
  sl.registerLazySingleton(() => AuthorizationCubit(autorizationUseCasesUser: sl()));
  sl.registerLazySingleton(() => AutorizationUseCasesUser(registrationsRepository :sl()));
  /// регистрация
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<Repository>(() => RegistrationUsersDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => RegistrationUseCasesUser(registrationsRepository :sl()));
  sl.registerLazySingleton(() => RegistrationCubit(registrationUseCasesUser : sl()));
}