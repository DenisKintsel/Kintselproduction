part of 'cargo_cubit.dart';

@freezed
abstract class CargoState with _$CargoState {
  const factory CargoState.initial(List output) = Initial;
  const factory CargoState.loading() = Loading;
  const factory CargoState.error() = Error;
}