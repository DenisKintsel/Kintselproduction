part of 'news_cubit.dart';

@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState.initial(List <NewsModel> news) = Initial;

  const factory NewsState.loading() = Loading;

  const factory NewsState.error() = Error;
}