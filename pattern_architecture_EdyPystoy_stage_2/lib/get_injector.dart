import 'package:get_it/get_it.dart';

import 'app/data/datasources/registation_users_datasources.dart';
import 'app/domain/repositories/repository.dart';
import 'app/domain/usecases/user/autorization_user.dart';
import 'app/domain/usecases/user/registration_user.dart';
import 'app/presentation/pages/autorization/cubit/autorization_cubit.dart';
import 'app/presentation/pages/registration/cubit/registration_cubit.dart';
import 'package:http/http.dart' as http;

var sl = GetIt.instance;

Future<void> initGet() async{
  sl.registerLazySingleton(() => AuthorizationCubit(autorizationUseCasesUser: sl()));
  sl.registerLazySingleton(() => AutorizationUseCasesUser(registrationsRepository :sl()));
  // регистрация
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<RegistrationsRepository>(() => RegistrationUsersDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => RegistrationUseCasesUser(registrationsRepository :sl()));
  sl.registerLazySingleton(() => RegistrationCubit(registrationUseCasesUser : sl()));
}