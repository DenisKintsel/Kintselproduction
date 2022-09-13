import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../get_injector.dart';
import '../cubit/cargo_cubit.dart';
import '../widget/cargo_widget.dart';

class CargoView extends StatelessWidget {
  const CargoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<CargoCubit>()..init(),
      child: BlocBuilder<CargoCubit, CargoState>(
          builder: (context, state) {
            return state.when(
              initial: (output) => CargoWidget(
                output: output,
                  onClick: () async =>
                      BlocProvider.of<CargoCubit>(context).onClickAd(),
              onPress:(id) async =>
                  BlocProvider.of<CargoCubit>(context).onPress(id)),
              loading: () => Container(child: Text("Загрузка")),
              error: () => Container(child: Text("Error")),
            );
          }),
    );
  }
}