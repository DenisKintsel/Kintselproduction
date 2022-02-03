part of 'list_sverka_bloc.dart';

abstract class ListSverkaEvent extends Equatable {
  const ListSverkaEvent();

  @override
  List<Object> get props => [];
}

class Init extends ListSverkaEvent {
  final Map idp ; 
  Init({required this.idp});
}

class Del extends ListSverkaEvent{
 final String id;

   Del({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Del { id: $id }';
}