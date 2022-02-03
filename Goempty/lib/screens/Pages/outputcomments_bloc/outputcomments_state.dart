part of 'outputcomments_bloc.dart';

abstract class OutputCommentsState extends Equatable {
  const OutputCommentsState();

  @override
  List<Object> get props => [];
}

class OutputCommentsInitial extends OutputCommentsState {
  final List comment;

  OutputCommentsInitial({this.comment});
}

class OutputCommentsLoading extends OutputCommentsState {}

class OutputCommentsFailure extends OutputCommentsState {
 final String error;

  OutputCommentsFailure({this.error});

}
