part of 'addcomments_bloc.dart';



abstract class AddCommentsState extends Equatable {
  const AddCommentsState();
  
  @override
  List<Object> get props => [];
}

class AddCommentsInitial extends AddCommentsState {}
class AddCommentsSuccess extends AddCommentsState {}
class AddCommentsLoading extends AddCommentsState {}
class AddCommentsFailure extends AddCommentsState {
  final String error;

  AddCommentsFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' AddCommentsFaliure { error: $error }';
}