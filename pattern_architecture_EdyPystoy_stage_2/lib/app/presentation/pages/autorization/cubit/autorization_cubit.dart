import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:pattern_architecture/app/domain/entities/user_model.dart';

import '../../../../core_global/error/failure.dart';
import '../../../../domain/usecases/user/autorization_user.dart';
part 'autorization_state.dart';
part 'autorization_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class AuthorizationCubit extends Cubit<AuthState> {
  final AutorizationUseCasesUser autorizationUseCasesUser;
  AuthorizationCubit({required this.autorizationUseCasesUser}) : super(const Initial());

  Future<void> incrementCount(int current) async {
    emit(const Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(Initial());
  }

  Future<void> autUser(
      String email, String password) async {
    emit(const Loading());
    final Either<Failure, userModel> autUsers =
    await autorizationUseCasesUser.call(AutorizationUser(
        email: email, password: password));

    autUsers.fold((failure) {
      Get.snackbar("Ой... что то пошло не так", "Попробуйте снова",
          duration: const Duration(milliseconds: 5000));
    }, (response) async {
      Get.snackbar("Регистрация успешно пройдена", "Создан ваш профиль",
          duration: const Duration(milliseconds: 5000));
    });
  }
}