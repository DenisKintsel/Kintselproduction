import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core_global/error/failure.dart';
import '../../../../domain/entities/list_bool_model.dart';
import '../../../../domain/usecases/NoParams/usecase.dart';
import '../../../../domain/usecases/bool/add_bool_usecases.dart';
import '../../../../domain/usecases/bool/out_bool_usecases.dart';

part 'bool_state.dart';

part 'bool_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class BoolCubit extends Cubit<BoolState> {
  final OutBoolUseCases outBoolUseCases;
  final AddBoolUseCases addBoolUseCases;

  BoolCubit(
      {required this.addBoolUseCases, required this.outBoolUseCases})
      : super(const Loading());

  Future<void> init() async {
    emit(const Loading());
    await Future.delayed(Duration(seconds: Random().nextInt(5)));
    await _outputBool();
  }

  Future<void> init2() async {
    await _outputBool();
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: Random().nextInt(5)));
    await init2();
  }

  Future<void> _outputBool() async {
    if (await InternetConnectionChecker().hasConnection == true) {
      final Either<Failure, listBoolModel> output =
          await outBoolUseCases(NoParams());
      return await output.fold(
        (failure) => emit(const Error()),
        (output) => emit(Initial(output)),
      );
    } else {
      var box = await Hive.openBox<listBoolModel>('List');
      final listBoolModel? output1 = box.get('List');
      print(box.get('List')?.listBool[0]);
      if (output1 != null) {
        print("Интернета нет");
        Get.snackbar("Ой... что то пошло не так", "Отсутствует интернет",
            duration: const Duration(milliseconds: 3000));
        print(output1.listBool[1]);
        emit(Initial(output1));
      } else {
        print("пустая БД");
        emit(const Error());
      }
    }
  }

  Future<void> syncingBool(
      int id,
      int switchQ,
      int radio,
      int check,
      int id2,
      int switchQ2,
      int radio2,
      int check2,
      int id3,
      int switchQ3,
      int radio3,
      int check3) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      final Either<Failure, NoParams> addBool = await addBoolUseCases.call(
          AddBool(
              id: id,
              switchQ: switchQ,
              radio: radio,
              check: check,
              id2: id2,
              switchQ2: switchQ2,
              radio2: radio2,
              check2: check2,
              id3: id3,
              switchQ3: switchQ3,
              radio3: radio3,
              check3: check3));

      addBool.fold((failure) {
        Get.snackbar("Ой... что то пошло не так", "Попробуйте снова",
            duration: const Duration(milliseconds: 3000));
      }, (response) async {
        Get.snackbar("Синхронизация", "Успешно пройдена",
            duration: const Duration(milliseconds: 3000));
        await init2();
      });
    }
  }

  Future<void> hiveSyncing(List<Map<String, int>> list) async {
    var box = await Hive.openBox<listBoolModel>('List');
    final listBoolModel listPut = listBoolModel(list);
    box.putAt(0, listPut);
  }
}
