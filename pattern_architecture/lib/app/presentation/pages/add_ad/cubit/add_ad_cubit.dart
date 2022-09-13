import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:pattern_architecture/app/core_global/error/failure.dart';
import '../../../../domain/usecases/NoParams/usecase.dart';
import '../../../../domain/usecases/add_ad/add_ad_usecases.dart';

part 'add_ad_state.dart';

part 'add_ad_cubit.freezed.dart';

class AddAdCubit extends Cubit<AddAdState> {
  final AddAdUseCases addAdUseCases;

  AddAdCubit({required this.addAdUseCases}) : super(const Initial());

  Future<void>init() async{
    emit(const Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(const Initial());
  }

  Future<void> add(String title, String car, String data, String notes,
      String departure, String receipt) async {
    emit(const Loading());
    final Either<Failure, NoParams> addAd =
        await addAdUseCases.call(AddAd(
            title: title,
            car: car,
            data: data,
            notes: notes,
            departure: departure,
            receipt: receipt));

    addAd.fold((failure) {
      Get.snackbar("Ой... что то пошло не так", "Попробуйте снова",
          duration: const Duration(milliseconds: 5000));
    }, (response) async {
      Get.snackbar("Ваше объявление", "Успешно добавлено",
          duration: const Duration(milliseconds: 5000));
    });
  }
}
