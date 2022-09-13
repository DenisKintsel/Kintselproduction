part of 'driver_car_cubit.dart';

@freezed
abstract class DriverCarState with _$DriverCarState {
  const factory DriverCarState.initial(List output) = Initial;
  const factory DriverCarState.loading() = Loading;
  const factory DriverCarState.error() = Error;
}