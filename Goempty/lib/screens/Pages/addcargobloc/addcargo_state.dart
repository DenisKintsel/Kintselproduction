part of 'addcargo_bloc.dart';



abstract class AddCargoState extends Equatable {
  const AddCargoState();
  
  @override
  List<Object> get props => [];
}

class AddCargoInitial extends AddCargoState {}
class AddCargoSuccess extends AddCargoState {}
class AddCargoLoading extends AddCargoState {}
class AddCargoFailure extends AddCargoState {
  final String error;

  AddCargoFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFaliure { error: $error }';
}