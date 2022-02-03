import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp2/repository/addcomments_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'addcomments_event.dart';
part 'addcomments_state.dart';

class AddCommentsBloc extends Bloc<AddCommentsEvent, AddCommentsState> {

  final addCommentsRepository = AddCommentsRepository();

  AddCommentsBloc() : super(AddCommentsLoading());

  @override
  Stream<AddCommentsState> mapEventToState(
    AddCommentsEvent event,
  ) async* {
    if (event is AddCommentsButtonPressed) {
      yield* mapAddCommentsToState(event);
    }
  }

  Stream<AddCommentsState> mapAddCommentsToState(event) async* {
    yield AddCommentsLoading();
    print("LoGIN: ${event.idusers} PASS: ${event.iduserA}" );
    try {
          bool result = await addCommentsRepository.addComments(event.idusers, event.iduserA, event.comments,event.star);
                if(result) {
                yield AddCommentsSuccess();
                }
                else{
                  yield AddCommentsFailure(error: "Ошибка авторизации");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield AddCommentsFailure(error: "Ошибка авторизации");
                  }
  }
}