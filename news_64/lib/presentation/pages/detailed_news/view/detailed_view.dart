import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_global/widget/loading.dart';
import '../../../../get_injector.dart';
import '../cubit/detailed_cubit.dart';
import '../widget/detailed_widget.dart';

class DetailedView extends StatelessWidget {
  final String id;
  const DetailedView({required this.id}) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<DetailedCubit>()..init(id),
      child:
      BlocBuilder<DetailedCubit, DetailedState>(builder: (context, state) {
        return state.when(
            initial: (detailed) => DetailedWidget(
              detailed: detailed,
            ),
            loading: () => LoadingWidget(),
            error: () => LoadingWidget()
        );
      }),
    );
  }
}