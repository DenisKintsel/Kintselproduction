import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core_global/error/failure.dart';
import '../../../../core_global/models/news_model/news_model.dart';
import '../../../../domain/usecases/news/news_usecases.dart';
import '../../detailed_news/view/detailed_view.dart';

part 'important_cubit.freezed.dart';

part 'important_state.dart';

class ImportantCubit extends Cubit<ImportantState> {
  final NewsUseCases newsUseCases;

  ImportantCubit({required this.newsUseCases}) : super(const Loading());

  List<NewsModel> list = [];

  Future<void> init() async {
    emit(const Loading());
    if (await InternetConnectionChecker().hasConnection == true) {
      final Either<Failure, List<NewsModel>> output =
          await newsUseCases(const Category(category: 'top', date: ''));
      return await output.fold(
        (failure) => emit(const Error()),
        (news) {
          list = [];
          list = [...list, ...news];
          emit(Initial(news));
        },
      );
    }
  }

  Future<void> onScroll(String date) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      final Either<Failure, List<NewsModel>> output =
          await newsUseCases(Category(category: '', date: date));
      return await output.fold(
        (failure) => emit(const Error()),
        (news) {
          list = [...list, ...news];
          emit(Initial(list));
        },
      );
    }
  }

  Future<void> onClick(String id) async {
    await Get.to(() => DetailedView(id: id));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<void> close() async {
    return dispose();
  }
}
