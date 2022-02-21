part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {
  final List list;

  ListInitial({required this.list});
}

class ListBD extends ListState {
  final List name;

  ListBD({required this.name});
}

class ListLoading extends ListState {}

class ListFailure extends ListState {
  final String error;

  ListFailure({required this.error});
}
