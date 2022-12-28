import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core_global/error/failure.dart';
import '../../../../core_global/models/news_model/news_model.dart';
import '../../../../domain/entities/list_model.dart';
import '../../../../domain/usecases/news/news_usecases.dart';
import '../../detailed_news/view/detailed_view.dart';

part 'news_cubit.freezed.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsUseCases newsUseCases;

  NewsCubit({required this.newsUseCases}) : super(const Loading());

  List<NewsModel> list = [];

  Future<void> init() async {
    var box = await Hive.openBox<listModel>('News');
    emit(const Loading());
    if (await InternetConnectionChecker().hasConnection == true) {
      await box.delete('News');
      final Either<Failure, List<NewsModel>> output =
          await newsUseCases(const Category(category: '', date: ''));
      return await output.fold(
        (failure) => emit(const Error()),
        (news) async {
          list = [];
          list = [...list, ...news];
          emit(Initial(news));
        },
      );
    } else {
      final bd = box.get('News');
      final List<NewsModel> listNews = List<NewsModel>.from(bd!.newsBD.map(
          (data) => NewsModel(
              id: data['id'],
              img: data['img'],
              date: data['date'],
              title: data['title'],
              important: data['important'],
              subtitle: data['subtitle'])));
      emit(Initial(listNews));
      Get.snackbar(
          "Ой... что то пошло не так", "Отсутствует подключение к интернету",
          duration: const Duration(milliseconds: 3000));
    }
  }

  Future<void> onScroll(String date) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      final Either<Failure, List<NewsModel>> output =
          await newsUseCases(Category(category: '', date: date));
      return await output.fold(
        (failure) => emit(const Error()),
        (news) async {
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