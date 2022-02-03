import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp2/bloc/auth_bloc.dart';
import 'package:flutterapp2/repository/user_repository.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'registr_event.dart';
part 'registr_state.dart';

class RegistrBloc extends Bloc<RegistrEvent, RegistrState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegistrBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(null);

  @override
  Stream<RegistrState> mapEventToState(
    RegistrEvent event,
  ) async* {
    if (event is RegistrButtonPressed) {
      yield* mapRegistrToState(event);
    }
  }

  Stream<RegistrState> mapRegistrToState(event) async* {
    yield RegistrLoading();
    print("LoGIN: ${event.email} PASS: ${event.password}" );
    try {
          bool result = await userRepository.signUp(event.username, event.password, event.email);
         if(result) {
         authenticationBloc.add(LoggedIn());
         yield RegistrSuccess();
        }
        else{
           yield RegistrFailure(error: "Ошибка авторизации");
        }
       
    } catch(e) {
      print("ERROR: $e");
      yield RegistrFailure(error: "Ошибка авторизации");
    }
  }
}
