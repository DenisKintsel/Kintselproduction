import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/driver_car_cubit.dart';
import '../../../../../get_injector.dart';
import '../widget/driver_car_widget.dart';

class DriverCarView extends StatelessWidget {
  const DriverCarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<DriverCarCubit>()..init(),
      child: BlocBuilder<DriverCarCubit, DriverCarState>(
          builder: (context, state) {
        return state.when(
          initial: (output) => DriverCarWidget(
            output: output,
              onClick: () async =>
                  BlocProvider.of<DriverCarCubit>(context).onClickAd()),
          loading: () => Container(child: Text("Загрузка")),
          error: () => Container(child: Text("Error")),
        );
      }),
    );
  }
}
