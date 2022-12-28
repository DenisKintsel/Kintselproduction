import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:news_64/presentation/pages/article/cubit/article_cubit.dart';
import 'package:news_64/presentation/pages/detailed_news/cubit/detailed_cubit.dart';
import 'package:news_64/presentation/pages/important/cubit/important_cubit.dart';
import 'package:news_64/presentation/pages/news_view/cubit/news_cubit.dart';

import 'data/datasources/datasources.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/detailedNews/detailed_news_usecases.dart';
import 'domain/usecases/news/news_usecases.dart';

var sl = GetIt.instance;

Future<void> initGet() async {
  ///Новости
  sl.registerLazySingleton(() => DetailedNewsUseCases(repository: sl()));
  sl.registerLazySingleton(() => DetailedCubit(detailedNewsUseCases: sl()));
  sl.registerLazySingleton(() => NewsUseCases(repository: sl()));
  sl.registerLazySingleton(() => NewsCubit(newsUseCases: sl()));
  sl.registerLazySingleton(() => ImportantCubit(newsUseCases: sl()));
  sl.registerLazySingleton(() => ArticleCubit(newsUseCases: sl()));

  /// репозиторий
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<Repository>(
      () => RegistrationUsersDataSourceImpl(client: sl()));
}
