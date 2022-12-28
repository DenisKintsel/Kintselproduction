import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_global/widget/loading.dart';
import '../../../../get_injector.dart';
import '../cubit/article_cubit.dart';
import '../widget/article_widget.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<ArticleCubit>()..init(),
      child:
      BlocBuilder<ArticleCubit, ArticleState>(builder: (context, state) {
        return state.when(
            initial: (news) => ArticleWidget(news: news,
              onScroll:(date) async =>
                  BlocProvider.of<ArticleCubit>(context).onScroll(date),
              onRefresh:() async =>
                  BlocProvider.of<ArticleCubit>(context).init(),
              onClick:(id) async =>
                  BlocProvider.of<ArticleCubit>(context).onClick(id),
            ),
            loading: () => LoadingWidget(),
            error: () => LoadingWidget()
        );
      }),
    );
  }
}