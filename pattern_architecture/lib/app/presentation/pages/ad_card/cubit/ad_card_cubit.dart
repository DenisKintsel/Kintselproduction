import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pattern_architecture/app/domain/usecases/NoParams/usecase.dart';
import '../../../../core_global/error/failure.dart';
import '../../../../domain/usecases/ad_output/ad_card_output_usecase.dart';
import '../../../../domain/usecases/order_status/ad_status_respond_usecases.dart';
import '../../add_cargo/page/add_cargo_page.dart';

part 'ad_card_state.dart';

part 'ad_card_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class AdCardCubit extends Cubit<AdCardState> {
  final AdCardUseCasesUser adCardUseCasesUser;
  final AdStatusRespondUseCases adStatusRespondUseCases;

  AdCardCubit({required this.adStatusRespondUseCases,required this.adCardUseCasesUser})
      : super(Loading());

  Future<void> init(int id) async {
    await outPutCargo(id);
  }

  Future<void> outPutCargo(int id) async {
    StreamController controller = StreamController();
    if (!controller.isClosed) {
      final Either<Failure, List> output =
          await adCardUseCasesUser.call(AdCardId(id: id));
      return await output.fold(
        (failure) => emit(const Error()),
        (output) => emit(Initial(output)),
      );
    } else {
      print("Else");
    }
  }

  @override
  Future<void> close() async {
    return close();
    // return super.close();
  }

  Future<void> onClickAd() async {
    await Get.to(() => const AddCargoView());
  }

  Future<void> respond(int idAd, int idUserClient, int statusOrder) async {
    emit(const Loading());
    final Either<Failure, NoParams> adStatus =
        await adStatusRespondUseCases.call(AdStatusRespond(
            idAd: idAd, idUserClient: idUserClient, statusOrder: statusOrder));

    adStatus.fold((failure) {
      Get.snackbar("Ой... что то пошло не так", "Попробуйте снова",
          duration: const Duration(milliseconds: 5000));
    }, (response) async {
      Get.back();
      Get.snackbar("Ваше объявление", "Успешно добавлено",
          duration: const Duration(milliseconds: 5000));
    });
  }
}
