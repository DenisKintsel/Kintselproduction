part of 'registr_bloc.dart';

abstract class RegistrEvent extends Equatable {
  const RegistrEvent();
}

class RegistrButtonPressed extends RegistrEvent {
  final String email;
  final String password;
  final String username;

  const RegistrButtonPressed({@required this.email, @required this.password, @required this.username});

  @override
  List<Object> get props => [email, password,username];

  @override
  String toString() => 'LoginButtonPressed { email: $email, password: $password }';
}
