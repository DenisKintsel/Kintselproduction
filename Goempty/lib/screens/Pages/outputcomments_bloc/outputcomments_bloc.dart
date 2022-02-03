import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp2/repository/outputcomments_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterapp2/screens/Pages/cargo_page/comments.dart';

part 'outputcomments_event.dart';
part 'outputcomments_state.dart';

class OutputCommentsBloc extends Bloc<OutputCommentsEvent, OutputCommentsState>{
  
  final _outputCommentsRepository = OutputCommentsRepository();

  OutputCommentsBloc() : super(OutputCommentsInitial(comment:[]));


  @override
  Stream<OutputCommentsState> mapEventToState(
    OutputCommentsEvent event,
  ) async* {
    if (event is Init) {
      yield* mapOutputCommentsInitToState(event);
    }
  }

  Stream<OutputCommentsState> mapOutputCommentsInitToState(event) async* {
    yield OutputCommentsLoading();
    Map searchid = event.searchid;
    try {
          Map getOutputComments = await _outputCommentsRepository.getOutputCommentsApi(searchid);
                   if(getOutputComments['status']){
                     if(getOutputComments['listCargo'].length==0){
                      yield OutputCommentsFailure(error: "Комментарии не найдены");
                     }
                     else{
                        yield OutputCommentsInitial(comment:getOutputComments['listCargo']);
                     }
                     }
                      else{
                        yield OutputCommentsFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield OutputCommentsFailure(error: "Ошибка подключения");
    }
  }
}
