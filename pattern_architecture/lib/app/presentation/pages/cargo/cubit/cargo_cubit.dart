import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pattern_architecture/app/domain/usecases/NoParams/usecase.dart';
import 'package:pattern_architecture/app/domain/usecases/ad_output/cargo_output.dart';
import '../../../../core_global/error/failure.dart';
import '../../../../domain/usecases/ad_output/driver_car_output.dart';
import '../../ad_card/view/ad_card_view.dart';
import '../../add_ad/view/add_ad_view.dart';
import '../../add_cargo/page/add_cargo_page.dart';
part 'cargo_state.dart';
part 'cargo_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class CargoCubit extends Cubit<CargoState> {
  final CargoOutPutUseCasesUser cargoOutPutUseCasesUser;
  CargoCubit({required this.cargoOutPutUseCasesUser}) : super(Loading());

  Future<void> init() async {
    await outPutCargo();
  }
  Future<void>outPutCargo() async {
    StreamController controller = StreamController();
    if(!controller.isClosed) {
      final Either<Failure, List> output =
      await cargoOutPutUseCasesUser(NoParams());
      return await output.fold(
            (failure) => emit(const Error()),
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
    await Get.to(() => const AddCargoView());
  }

  Future<void>onPress(int id) async{
    await Get.to(() => AdCardView(id: id));
  }
}