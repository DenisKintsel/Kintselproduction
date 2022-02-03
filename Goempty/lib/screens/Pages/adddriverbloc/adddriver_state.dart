part of 'adddriver_bloc.dart';



abstract class AddDriverState extends Equatable {
  const AddDriverState();
  
  @override
  List<Object> get props => [];
}

class AddDriverInitial extends AddDriverState {}
class AddDriverSuccess extends AddDriverState {}
class AddDriverLoading extends AddDriverState {}
class AddDriverFailure extends AddDriverState {
  final String error;

  AddDriverFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' DriverFaliure { error: $error }';
}