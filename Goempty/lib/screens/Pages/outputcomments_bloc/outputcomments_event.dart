part of 'outputcomments_bloc.dart';

abstract class OutputCommentsEvent extends Equatable {
  const OutputCommentsEvent();

  @override
  List<Object> get props => [];
}

class Init extends OutputCommentsEvent {
  final Map searchid ; 
  Init({this.searchid});
  
}