part of 'splash_screen_cubit.dart';

@freezed
 class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState.initial() = Initial;
  const factory SplashScreenState.loading() = Loading;
  const factory SplashScreenState.error() = Error;
  const factory SplashScreenState.success() = Success;
}