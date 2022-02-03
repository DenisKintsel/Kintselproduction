import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../repository/delete_sverka_repository.dart';


part 'delete_sverka_event.dart';
part 'delete_sverka_state.dart';

class DeleteSverkaBloc extends Bloc<DeleteSverkaEvent, DeleteSverkaState> {

  final deleteSverkaRepository = DeleteSverkaRepository();

  DeleteSverkaBloc() : super(DeleteSverkaLoading());

  @override
  Stream<DeleteSverkaState> mapEventToState(
    DeleteSverkaEvent event,
  ) async* {
    if (event is DeleteSverkaButtonPressed) {
      yield* mapDeleteSverkaToState(event);
    }
  }

  Stream<DeleteSverkaState> mapDeleteSverkaToState(event) async* {
    yield DeleteSverkaLoading();
    try {
          bool result = await deleteSverkaRepository.deleteSverka(event.id);
                if(result) {
                yield DeleteSverkaSuccess();
                }
                else{
                  yield DeleteSverkaFailure(error: "Ошибка");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield DeleteSverkaFailure(error: "Ошибка");
                  }
  }
}