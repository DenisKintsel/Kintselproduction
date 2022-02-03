part of 'my_profil_bloc.dart';

abstract class MyProfilState extends Equatable {
  const MyProfilState();

  @override
  List<Object> get props => [];
}

class MyProfilInitial extends MyProfilState {
  final List myinf;

  MyProfilInitial({this.myinf});
}

class MyProfilLoading extends MyProfilState {}

class MyProfilFailure extends MyProfilState {
 final String error;

  MyProfilFailure({this.error});

}