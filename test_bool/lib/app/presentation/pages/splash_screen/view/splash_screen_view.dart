import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import '../../../../../get_injector.dart';
import '../../../widget/loading.dart';
import '../cubit/splash_screen_cubit.dart';
import '../widget/splash_screen_widget.dart';

class SplashScreenView extends StatelessWidget{
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SplashScreenCubit>()..init(),
      child: BlocBuilder<SplashScreenCubit, SplashScreenState>(
          builder: (context, state) {
            return state.when(
              loading:() => const SplashScreenWidget(),
                initial:() => const SplashScreenWidget(),
              error:() => LoadingWidget(),
              success: () => const SplashScreenWidget()
            );
          }),
    );
  }

}