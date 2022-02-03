import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutterapp2/repository/adddriver_repository.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'adddriver_event.dart';
part 'adddriver_state.dart';

class AddDriverBloc extends Bloc<AddDriverEvent, AddDriverState> {

  final addDriverRepository = AddDriverRepository();

  AddDriverBloc() : super(AddDriverLoading());

  @override
  Stream<AddDriverState> mapEventToState(
    AddDriverEvent event,
  ) async* {
    if (event is AddDriverButtonPressed) {
      yield* mapAddDriverToState(event);
    }
  }

  Stream<AddDriverState> mapAddDriverToState(event) async* {
    yield AddDriverLoading();
    print("LoGIN: ${event.city1} PASS: ${event.city2}" );
    try {
          bool result = await addDriverRepository.addDriver(event.city1, event.city2, event.car, event.price, event.phone, event.note,event.data,event.id);
                if(result) {
                yield AddDriverSuccess();
                }
                else{
                  yield AddDriverFailure(error: "Ошибка авторизации");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield AddDriverFailure(error: "Ошибка авторизации");
                  }
  }
}