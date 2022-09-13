import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_architecture/app/presentation/pages/add_cargo/cubit/add_cargo_cubit.dart';
import '../../../../../get_injector.dart';
import '../widget/add_cargo_widget.dart';

class AddCargoView extends StatelessWidget {
  const AddCargoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AddCargoCubit>()..init(),
      child:
          BlocBuilder<AddCargoCubit, AddCargoState>(builder: (context, state) {
        return state.when(
          initial: () => AddCargoWidget(
            addCargo: (title, cargo, notes, departure, receipt, data) async =>
                BlocProvider.of<AddCargoCubit>(context)
                    .add(title, cargo, data, notes, departure, receipt),
          ),
          loading: () => AddCargoWidget(
            addCargo: (title, cargo, notes, departure, receipt, data) async =>
                BlocProvider.of<AddCargoCubit>(context)
                    .add(title, cargo, data, notes, departure, receipt),
          ),
          error: () => Container(child: Text("Error")),
        );
      }),
    );
  }
}
