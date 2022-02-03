import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/list_agent_repository.dart';
part 'list_agent_event.dart';
part 'list_agent_state.dart';

class ListAgentBloc extends Bloc<ListAgentEvent, ListAgentState>{
  
  final _listAgentRepository = ListAgentRepository();

  ListAgentBloc() : super(ListAgentInitial(listAgent:[]));

  @override
  Stream<ListAgentState> mapEventToState(
    ListAgentEvent event,
  ) async* {
    if (event is Init) {
      yield* mapListAgentInitToState();
    }if(event is DelAgent){
      yield* mapListDelAgentInitToState(event);
    }
  }

  Stream<ListAgentState> mapListAgentInitToState() async* {
    yield ListAgentLoading();
    try {
          Map getListAgent = await _listAgentRepository.getListAgentApi();
                   if(getListAgent['status']){
                     if(getListAgent['listAgent'].length==0){
                       yield ListAgentFailure(error: "Ничего не найдено");
                     }
                     else{
                      yield ListAgentInitial(listAgent:getListAgent['listAgent']);
                     }
                      }
                      else{
                        yield ListAgentFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield ListAgentFailure(error: "Ошибка сервера, перезайдите в программу");
    }
  }

 Stream<ListAgentState> mapListDelAgentInitToState(event) async* {
    yield ListAgentLoading();
    try {
          bool result = await _listAgentRepository.getDelAgentApi(event.id);
                if(result) {
                yield DelAgentSuccess();
                }
                else{
                  yield DelAgentFailure(error: "Ошибка");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield DelAgentFailure(error: "Ошибка");
                  }
  }
}