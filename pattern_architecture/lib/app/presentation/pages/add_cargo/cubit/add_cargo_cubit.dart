import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:pattern_architecture/app/core_global/error/failure.dart';
import '../../../../domain/usecases/NoParams/usecase.dart';
import '../../../../domain/usecases/add_ad/add_cargo_usecases.dart';

part 'add_cargo_state.dart';

part 'add_cargo_cubit.freezed.dart';

class AddCargoCubit extends Cubit<AddCargoState> {
  final AddCargoUseCases addCargoUseCases;

  AddCargoCubit({required this.addCargoUseCases}) : super(const Initial());

  Future<void> init() async {
    emit(const Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(const Initial());
  }

  Future<void> add(String title, String cargo, String data, String notes,
      String departure, String receipt) async {
    emit(const Loading());
    final Either<Failure, NoParams> addCargo = await addCargoUseCases.call(
        AddCargo(
            title: title,
            cargo: cargo,
            data: data,
            notes: notes,
            departure: departure,
            receipt: receipt));

    addCargo.fold((failure) {
      Get.snackbar("Ой... что то пошло не так", "Попробуйте снова",
          duration: const Duration(milliseconds: 5000));
    }, (response) async {
      Get.back();
      Get.snackbar("Ваше объявление", "Успешно добавлено",
          duration: const Duration(milliseconds: 5000));
    });
  }
}
