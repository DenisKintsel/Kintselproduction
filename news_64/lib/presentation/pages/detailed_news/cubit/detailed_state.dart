part of 'detailed_cubit.dart';

@freezed
abstract class DetailedState with _$DetailedState {
  const factory DetailedState.initial(NewsDetailedModel detailed) = Initial;

  const factory DetailedState.loading() = Loading;

  const factory DetailedState.error() = Error;
}