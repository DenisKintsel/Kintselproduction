part of 'list_agent_bloc.dart';

abstract class ListAgentEvent extends Equatable {
  const ListAgentEvent();

  @override
  List<Object> get props => [];
}

class Init extends ListAgentEvent {
  
}
class DelAgent extends ListAgentEvent{
 final String id;

   DelAgent({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Del { id: $id }';
}