part of 'driver_bloc.dart';

abstract class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {
  final List driver;

  DriverInitial({this.driver});
}

class DriverLoading extends DriverState {}

class DriverFailure extends DriverState {
 final String error;

  DriverFailure({this.error});

}
