import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:pattern_architecture/app/core_global/error/failure.dart';

import '../../../../domain/usecases/NoParams/usecase.dart';
import '../../../../domain/usecases/user/registration_user.dart';
import '../../autorization/view/autorizatoin_view.dart';

part 'registration_state.dart';

part 'registration_cubit.freezed.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationUseCasesUser registrationUseCasesUser;

  RegistrationCubit({required this.registrationUseCasesUser})
      : super(const Initial());

  Future<void> incrementCount(int current) async {
    emit(const Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(const Initial());
  }

  Future<void> regUser(
      String email, String name, String city, String password) async {
    emit(const Loading());
    final Either<Failure, NoParams> registrationUsers =
        await registrationUseCasesUser.call(RegistrUser(
            email: email, password: password, name: name, city: city));

    registrationUsers.fold((failure) {
      Get.snackbar("Ой... что то пошло не так", "Попробуйте снова",
          duration: const Duration(milliseconds: 5000));
    }, (response) async {
      Get.snackbar("Регистрация успешно пройдена", "Создан ваш профиль",
          duration: const Duration(milliseconds: 5000));
      await Get.to(() => const AutorizationView());
    });
  }
}
