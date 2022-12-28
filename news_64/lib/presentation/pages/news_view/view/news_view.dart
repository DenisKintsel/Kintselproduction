import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_global/widget/loading.dart';
import '../../../../get_injector.dart';
import '../cubit/news_cubit.dart';
import '../widget/news_widget.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<NewsCubit>()..init(),
      child:
      BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
        return state.when(
            initial: (news) => NewsWidget(
              news: news,
              onScroll:(date) async =>
                BlocProvider.of<NewsCubit>(context).onScroll(date),
              onRefresh:() async =>
                  BlocProvider.of<NewsCubit>(context).init(),
              onClick:(id) async =>
                  BlocProvider.of<NewsCubit>(context).onClick(id),
            ),
            loading: () => LoadingWidget(),
            error: () => LoadingWidget()
        );
      }),
    );
  }
}