part of 'prof_ad_bloc.dart';


abstract class ProfAdEvent extends Equatable {
  const ProfAdEvent();

  @override
  List<Object> get props => [];
}

class ProfAdInit extends ProfAdEvent {
  final Map idAS ; 
  ProfAdInit({this.idAS});
  
}