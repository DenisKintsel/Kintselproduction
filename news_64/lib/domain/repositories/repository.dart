import 'package:dartz/dartz.dart';
import '../../core_global/error/failure.dart';
import '../../core_global/models/news_detailed_model/news_detailed_model.dart';
import '../../core_global/models/news_model/news_model.dart';
import '../entities/list_model.dart';
import '../usecases/NoParams/usecase.dart';

abstract class Repository {
  Future<Either<Failure, List<NewsModel>>> newNews(
      String category, String date);

  Future<Either<Failure, NewsDetailedModel>> detailedNews(String id);
}
