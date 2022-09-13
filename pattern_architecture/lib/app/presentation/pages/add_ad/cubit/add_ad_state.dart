part of 'add_ad_cubit.dart';

@freezed
abstract class AddAdState with _$AddAdState {
  const factory AddAdState.initial() = Initial;
  const factory AddAdState.loading() = Loading;
  const factory AddAdState.error() = Error;
}