import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core_global/error/failure.dart';
import '../../../core_global/models/news_detailed_model/news_detailed_model.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class DetailedNewsUseCases extends UseCase<NewsDetailedModel, Detailed> {
  final Repository repository;

  DetailedNewsUseCases({required this.repository});

  @override
  Future<Either<Failure, NewsDetailedModel>> call(Detailed params) async {
    final Either<Failure, NewsDetailedModel> output =
    await repository.detailedNews(
        params.id
    );
    return output.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}

class Detailed extends Equatable {
  final String id;
  const Detailed(
      {required this.id});

  @override
  List<Object?> get props => [];
}