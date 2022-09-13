part of 'add_cargo_cubit.dart';

@freezed
abstract class AddCargoState with _$AddCargoState {
  const factory AddCargoState.initial() = Initial;
  const factory AddCargoState.loading() = Loading;
  const factory AddCargoState.error() = Error;
}