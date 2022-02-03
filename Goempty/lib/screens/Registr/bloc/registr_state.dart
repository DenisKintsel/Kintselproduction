part of 'registr_bloc.dart';

abstract class RegistrState extends Equatable {
  const RegistrState();
  
  @override
  List<Object> get props => [];
}

class RegistrInitial extends RegistrState {}
class RegistrSuccess extends RegistrState {}
class RegistrLoading extends RegistrState {}
class RegistrFailure extends RegistrState {
  final String error;

  RegistrFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFaliure { error: $error }';
}
