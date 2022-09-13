part of 'registration_cubit.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = Initial;
  const factory RegistrationState.loading() = Loading;
  const factory RegistrationState.error() = Error;
}