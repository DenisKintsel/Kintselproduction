import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import '../repository/addagent_repository.dart';
part 'addagent_event.dart';
part 'addagent_state.dart';

class AddAgentBloc extends Bloc<AddAgentEvent, AddAgentState> {

  final addAgentRepository = AddAgentRepository();

  AddAgentBloc() : super(AddAgentLoading());

  @override
  Stream<AddAgentState> mapEventToState(
    AddAgentEvent event,
  ) async* {
    if (event is AddAgentButtonPressed) {
      yield* mapAddAgentToState(event);
    }
  }

  Stream<AddAgentState> mapAddAgentToState(event) async* {
    yield AddAgentLoading();
    print("LoGIN: ${event.name} PASS: ${event.inn}" );
    try {
          bool result = await addAgentRepository.addAgent(event.name, event.inn, event.kpp,event.note);
                if(result) {
                yield AddAgentSuccess();
                }
                else{
                  yield AddAgentFailure(error: "Ошибка ");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield AddAgentFailure(error: "Ошибка ");
                  }
  }
}