part of 'addsverka_bloc.dart';


abstract class AddSverkaEvent extends Equatable {
  const AddSverkaEvent();
}

class AddSverkaButtonPressed extends AddSverkaEvent {
  final String datego;
  final String datefinish;
  final String namber;
  final String res;
  final String note;
  final String id;

  const AddSverkaButtonPressed({required this.datego, required this.datefinish, required this.namber, required this.res, required this.note, required this.id});

  @override
  List<Object> get props => [datego, datefinish,namber,res,note,id];

  @override
  String toString() => 'AddSverkaPressed { email: $datego, password: $id }';
}

class EditSverkaButtonPressed extends AddSverkaEvent {
  final String namber;
  final String res;
  final String note;
  final String id;

  const EditSverkaButtonPressed({required this.namber, required this.res, required this.note, required this.id});

  @override
  List<Object> get props => [namber,res,note,id];

  @override
  String toString() => 'EditSverkaPressed {  id: $id }';
}