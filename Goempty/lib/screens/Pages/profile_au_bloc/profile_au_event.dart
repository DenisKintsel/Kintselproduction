part of 'profile_au_bloc.dart';


abstract class ProfileAuEvent extends Equatable {
  const ProfileAuEvent();

  @override
  List<Object> get props => [];
}

class Init extends ProfileAuEvent {
  final Map idAS ; 
  Init({this.idAS});
  
}