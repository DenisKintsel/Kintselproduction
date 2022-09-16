part of 'bool_cubit.dart';

@freezed
abstract class BoolState with _$BoolState {
  const factory BoolState.initial(listBoolModel output) = Initial;
  const factory BoolState.loading() = Loading;
  const factory BoolState.error() = Error;
}