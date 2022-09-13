import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pattern_architecture/app/domain/usecases/NoParams/usecase.dart';

import '../../../../core_global/error/failure.dart';
import '../../../../domain/entities/user_model.dart';
import '../../../../domain/usecases/check_hive_user/check_user_account.dart';
import '../../autorization/view/autorizatoin_view.dart';
import '../../home/home.dart';
part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart'; // Dont forget to write this line as the generate code will be part for this file

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final CheckHiveUseCasesUser checkHiveUseCasesUser;
  SplashScreenCubit({ required this.checkHiveUseCasesUser}) : super(const Initial());

  Future<void> init() async {
   await Hive.openBox<userModel>('user');
    await Future.delayed(const Duration(seconds: 3));
    emit(const Initial());
    final Either<Failure, userModel> userAccount =
        await checkHiveUseCasesUser(NoParams());
    return await userAccount.fold(
            (failure) async{
              print("Fail222222222222222222");
              print(failure);
              await Get.to(() => const AutorizationView());
            },
            (userAccount) async{
              print("Yes77777777777777777777");
              if(userAccount.email.isNotEmpty) {
                await Get.offAll(() => const Home());
              } else {
                await Get.to(() => const AutorizationView());
              }
            }
    );
  }
  Future<void>authUser() async {}
}