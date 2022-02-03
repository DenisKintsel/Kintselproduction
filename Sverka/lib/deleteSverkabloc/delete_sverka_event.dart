part of 'delete_sverka_bloc.dart';


abstract class DeleteSverkaEvent extends Equatable {
  const DeleteSverkaEvent();
}

class DeleteSverkaButtonPressed extends DeleteSverkaEvent {
  final String id;

  const DeleteSverkaButtonPressed({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'DeleteSverkaPressed { id: $id }';
}