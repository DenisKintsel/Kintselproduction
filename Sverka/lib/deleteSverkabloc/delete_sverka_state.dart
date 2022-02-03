part of 'delete_sverka_bloc.dart';



abstract class DeleteSverkaState extends Equatable {
  const DeleteSverkaState();
  
  @override
  List<Object> get props => [];
}

class DeleteSverkaInitial extends DeleteSverkaState {}
class DeleteSverkaSuccess extends DeleteSverkaState {}
class DeleteSverkaLoading extends DeleteSverkaState {}
class DeleteSverkaFailure extends DeleteSverkaState {
  final String error;

  DeleteSverkaFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' DeleteSverkaFaliure { error: $error }';
}