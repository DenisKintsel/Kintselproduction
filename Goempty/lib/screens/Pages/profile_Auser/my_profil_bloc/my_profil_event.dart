part of 'my_profil_bloc.dart';


abstract class MyProfilEvent extends Equatable {
  const MyProfilEvent();

  @override
  List<Object> get props => [];
}

class Initt extends MyProfilEvent {
  final Map idMy ; 
  Initt({this.idMy});
  
}