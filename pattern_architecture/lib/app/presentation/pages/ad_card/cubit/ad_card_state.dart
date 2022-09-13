part of 'ad_card_cubit.dart';

@freezed
abstract class AdCardState with _$AdCardState {
  const factory AdCardState.initial(List output) = Initial;
  const factory AdCardState.loading() = Loading;
  const factory AdCardState.error() = Error;
}