import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pattern_architecture/app/domain/usecases/NoParams/usecase.dart';

import '../../../../core_global/error/failure.dart';
import '../../../../domain/entities/user_model.dart';
import '../../../../domain/usecases/ad_output/driver_car_output.dart';
import '../../../../domain/usecases/check_hive_user/check_user_account.dart';
import '../../add_ad/view/add_ad_view.dart';
import '../../autorization/view/autorizatoin_view.dart';
import '../../home/home.dart';
import '../view/driver_car_view.dart';
part 'driver_car_state.dart';
part 'driver_car_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class DriverCarCubit extends Cubit<DriverCarState> {
 final DriverCarOutPutUseCasesUser outPutUseCasesUser;
  DriverCarCubit({required this.outPutUseCasesUser}) : super(Loading());

  Future<void> init() async {
    await outPutDriverCar();
  }
  Future<void>outPutDriverCar() async {
    StreamController _controller = StreamController();
    if(!_controller.isClosed) {
      final Either<Failure, List> output =
      await outPutUseCasesUser(NoParams());
      return await output.fold(
            (failure) => emit(Error()),
            (output) => emit(Initial(output)),
      );
    }else{
      print("Else");
    }
  }

  @override
  Future<void> close() async {
    return close();
   // return super.close();
  }
  Future<void>onClickAd() async{
    await Get.to(() => const AddAdView());
  }
}