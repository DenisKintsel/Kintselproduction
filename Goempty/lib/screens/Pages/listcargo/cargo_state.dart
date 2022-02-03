part of 'cargo_bloc.dart';

abstract class CargoState extends Equatable {
  const CargoState();

  @override
  List<Object> get props => [];
}

class CargoInitial extends CargoState {
  final List cargo;

  CargoInitial({this.cargo});
}

class CargoLoading extends CargoState {}

class CargoFailure extends CargoState {
 final String error;

  CargoFailure({this.error});

}
