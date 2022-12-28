import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_global/widget/loading.dart';
import '../../../../get_injector.dart';
import '../cubit/important_cubit.dart';
import '../widget/important_widget.dart';

class ImportantView extends StatelessWidget {
  const ImportantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<ImportantCubit>()..init(),
      child: BlocBuilder<ImportantCubit, ImportantState>(
          builder: (context, state) {
        return state.when(
            initial: (news) => ImportantWidget(
                  news: news,
                  onScroll: (date) async =>
                      BlocProvider.of<ImportantCubit>(context).onScroll(date),
                  onRefresh: () async =>
                      BlocProvider.of<ImportantCubit>(context).init(),
                  onClick: (id) async =>
                      BlocProvider.of<ImportantCubit>(context).onClick(id),
                ),
            loading: () => LoadingWidget(),
            error: () => LoadingWidget());
      }),
    );
  }
}
