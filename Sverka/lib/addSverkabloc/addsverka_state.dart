part of 'addsverka_bloc.dart';



abstract class AddSverkaState extends Equatable {
  const AddSverkaState();
  
  @override
  List<Object> get props => [];
}

class AddSverkaInitial extends AddSverkaState {}
class AddSverkaSuccess extends AddSverkaState {}
class AddSverkaLoading extends AddSverkaState {}
class AddSverkaFailure extends AddSverkaState {
  final String error;

  AddSverkaFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' AddSverkaFaliure { error: $error }';
}

class EditSverkaSuccess extends AddSverkaState {}
class EditSverkaFailure extends AddSverkaState {
  final String error;

  EditSverkaFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EditSverkaFaliure { error: $error }';
}