part of 'article_cubit.dart';

@freezed
abstract class ArticleState with _$ArticleState {
  const factory ArticleState.initial(List <NewsModel> news) = Initial;

  const factory ArticleState.loading() = Loading;

  const factory ArticleState.error() = Error;
}