part of 'my_prof_ad_bloc.dart';


abstract class MyProfAdEvent extends Equatable {
  const MyProfAdEvent();

  @override
  List<Object> get props => [];
}

class MyProfAdInit extends MyProfAdEvent {
  final Map idAS ; 
  MyProfAdInit({this.idAS});
  
}