import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_bool/app/domain/usecases/NoParams/usecase.dart';

import '../../../../core_global/error/failure.dart';
import '../../bool_view/view/bool_view.dart';
part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const Initial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(const Initial());
   await Get.offAll(() => const ListBoolView());
  }
  Future<void>authUser() async {}
}