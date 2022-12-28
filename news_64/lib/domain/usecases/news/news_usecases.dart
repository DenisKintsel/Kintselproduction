import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core_global/error/failure.dart';
import '../../../core_global/models/news_model/news_model.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class NewsUseCases extends UseCase<List<NewsModel>, Category> {
  final Repository repository;

  NewsUseCases({required this.repository});

  @override
  Future<Either<Failure, List<NewsModel>>> call(Category params) async {
    final Either<Failure, List<NewsModel>> output =
    await repository.newNews(
      params.category,
      params.date
    );
    return output.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}

class Category extends Equatable {
  final String category;
  final String date;
  const Category(
      {required this.category,
      required this.date});

  @override
  List<Object?> get props => [];
}