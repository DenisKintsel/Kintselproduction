import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../repository/addsverka_repository.dart';

part 'addsverka_event.dart';
part 'addsverka_state.dart';

class AddSverkaBloc extends Bloc<AddSverkaEvent, AddSverkaState> {

  final addSverkaRepository = AddSverkaRepository();

  AddSverkaBloc() : super(AddSverkaLoading());

  @override
  Stream<AddSverkaState> mapEventToState(
    AddSverkaEvent event,
  ) async* {
    if (event is AddSverkaButtonPressed) {
      yield* mapAddSverkaToState(event);
    } if(event is EditSverkaButtonPressed){
      yield* mapEditSverkaToState(event);
    }
  }

  Stream<AddSverkaState> mapAddSverkaToState(event) async* {
    yield AddSverkaLoading();
    try {
          bool result = await addSverkaRepository.addSverka(event.datego, event.datefinish, event.namber, event.res, event.note,event.id);
                if(result) {
                yield AddSverkaSuccess();
                }
                else{
                  yield AddSverkaFailure(error: "Ошибка");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield AddSverkaFailure(error: "Ошибка, попробуйте снова");
                  }
  }


Stream<AddSverkaState> mapEditSverkaToState(event) async* {
    yield AddSverkaLoading();
    try {
          bool result = await addSverkaRepository.editSverka(event.namber, event.res, event.note,event.id);
                if(result) {
                yield EditSverkaSuccess();
                }
                else{
                  yield EditSverkaFailure(error: "Ошибка");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield EditSverkaFailure(error: "Ошибка, попробуйте снова");
                  }
  }
}