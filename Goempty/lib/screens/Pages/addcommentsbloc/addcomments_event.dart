part of 'addcomments_bloc.dart';


abstract class AddCommentsEvent extends Equatable {
  const AddCommentsEvent();
}

class AddCommentsButtonPressed extends AddCommentsEvent {
  final String idusers;
  final String iduserA;
  final String comments;
  final String star;
  const AddCommentsButtonPressed({@required this.idusers, @required this.iduserA,@required this.comments,@required this.star,});

  @override
  List<Object> get props => [idusers, iduserA,comments,star];

  @override
  String toString() => 'AddCommentsButtonPressed { email: $idusers, password: $iduserA }';
}