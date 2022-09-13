part of 'orders_cubit.dart';

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = Initial;
  const factory OrdersState.loading() = Loading;
  const factory OrdersState.error() = Error;
}