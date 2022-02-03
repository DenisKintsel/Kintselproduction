part of 'addagent_bloc.dart';


abstract class AddAgentEvent extends Equatable {
  const AddAgentEvent();
}

class AddAgentButtonPressed extends AddAgentEvent {
  final String name;
  final String inn;
  final String kpp;
  final String note;


  const AddAgentButtonPressed({required this.name, required this.inn, required this.kpp,required this.note});

  @override
  List<Object> get props => [name, inn,kpp,note];

  @override
  String toString() => 'AddAgentButtonPressed { name: $name, inn: $inn }';
}
