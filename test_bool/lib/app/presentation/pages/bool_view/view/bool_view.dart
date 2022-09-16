
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../get_injector.dart';
import '../../../widget/loading.dart';
import '../cubit/bool_cubit.dart';
import '../widget/bool_widget.dart';

class ListBoolView extends StatelessWidget {
  const ListBoolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<BoolCubit>()..init(),
      child:
          BlocBuilder<BoolCubit, BoolState>(builder: (context, state) {
        return state.when(
          initial: (output) => ListBool(
            syncingBool: (id,switchQ,radio,check,id2,switchQ2,radio2,
                check2,id3,switchQ3,radio3,check3) async =>
              BlocProvider.of<BoolCubit>(context)
              .syncingBool(id,switchQ,radio,check,id2,switchQ2,radio2,
              check2,id3,switchQ3,radio3,check3),
            output: output,
            hiveSyncing: (list) async =>BlocProvider.of<BoolCubit>(context).hiveSyncing(list),
            onRefresh: () async =>
                BlocProvider.of<BoolCubit>(context).onRefresh(),
          ),
          loading: () => LoadingWidget(),
          error: () => LoadingWidget()
        );
      }),
    );
  }
}