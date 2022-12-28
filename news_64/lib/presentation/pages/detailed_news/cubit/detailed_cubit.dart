import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core_global/error/failure.dart';
import '../../../../core_global/models/news_detailed_model/news_detailed_model.dart';
import '../../../../domain/usecases/detailedNews/detailed_news_usecases.dart';

part 'detailed_cubit.freezed.dart';

part 'detailed_state.dart';

class DetailedCubit extends Cubit<DetailedState> {
  final DetailedNewsUseCases detailedNewsUseCases;

  DetailedCubit({required this.detailedNewsUseCases}) : super(const Loading());

  Future<void> init(String id) async {
    emit(const Loading());
    if (await InternetConnectionChecker().hasConnection == true) {
      final Either<Failure, NewsDetailedModel> output =
          await detailedNewsUseCases(Detailed(id: id));
      return await output.fold(
        (failure) => emit(const Error()),
        (news) {
          emit(Initial(news));
        },
      );
    }
  }

  Future<void> dispose() async {}

  @override
  Future<void> close() async {
    return dispose();
  }
}
