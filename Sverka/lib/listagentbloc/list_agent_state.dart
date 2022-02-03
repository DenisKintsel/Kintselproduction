part of 'list_agent_bloc.dart';

abstract class ListAgentState extends Equatable {
  const ListAgentState();

  @override
  List<Object> get props => [];
}

class ListAgentInitial extends ListAgentState {
  final List listAgent;

  ListAgentInitial({required this.listAgent});
}

class ListAgentLoading extends ListAgentState {}

class ListAgentFailure extends ListAgentState {
 final String error;

 ListAgentFailure({required this.error});

}

class DelAgentSuccess extends ListAgentState {}

class DelAgentFailure extends ListAgentState {
 final String error;

   DelAgentFailure({required this.error});

}