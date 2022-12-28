part of 'important_cubit.dart';

@freezed
abstract class ImportantState with _$ImportantState {
  const factory ImportantState.initial(List <NewsModel> news) = Initial;

  const factory ImportantState.loading() = Loading;

  const factory ImportantState.error() = Error;
}