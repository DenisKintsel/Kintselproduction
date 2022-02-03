import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutterapp2/repository/addcargo_repository.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'addcargo_event.dart';
part 'addcargo_state.dart';

class AddCargoBloc extends Bloc<AddCargoEvent, AddCargoState> {

  final addCargoRepository = AddCargoRepository();

  AddCargoBloc() : super(AddCargoLoading());

  @override
  Stream<AddCargoState> mapEventToState(
    AddCargoEvent event,
  ) async* {
    if (event is AddCargoButtonPressed) {
      yield* mapAddCargoToState(event);
    }
  }

  Stream<AddCargoState> mapAddCargoToState(event) async* {
    yield AddCargoLoading();
    print("LoGIN: ${event.city1} PASS: ${event.city2}" );
    try {
          bool result = await addCargoRepository.addCargo(event.city1, event.city2, event.cargo, event.price, event.phone, event.note,event.id);
                if(result) {
                yield AddCargoSuccess();
                }
                else{
                  yield AddCargoFailure(error: "Ошибка авторизации");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield AddCargoFailure(error: "Ошибка авторизации");
                  }
  }
}
