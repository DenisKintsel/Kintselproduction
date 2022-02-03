part of 'list_sverka_bloc.dart';

abstract class ListSverkaState extends Equatable {
  const ListSverkaState();

  @override
  List<Object> get props => [];
}

class ListSverkaInitial extends ListSverkaState {
  final List listSverka;

   const ListSverkaInitial({required this.listSverka});
}

class ListSverkaLoading extends ListSverkaState {}

class ListSverkaFailure extends ListSverkaState {
 final String error;

   ListSverkaFailure({required this.error});

}

class DelSverkaSuccess extends ListSverkaState {}

class DelSverkaFailure extends ListSverkaState {
 final String error;

   DelSverkaFailure({required this.error});

}
