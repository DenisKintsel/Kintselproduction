part of 'addagent_bloc.dart';

abstract class AddAgentState extends Equatable {
  const AddAgentState();
  
  @override
  List<Object> get props => [];
}

class AddAgentInitial extends AddAgentState {}
class AddAgentSuccess extends AddAgentState {}
class AddAgentLoading extends AddAgentState {}
class AddAgentFailure extends AddAgentState {
  final String error;

   AddAgentFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' AddAgentFaliure { error: $error }';
}