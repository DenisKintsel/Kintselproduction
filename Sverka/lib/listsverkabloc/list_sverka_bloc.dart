import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/list_sverka_repository.dart';
part 'list_sverka_event.dart';
part 'list_sverka_state.dart';

class ListSverkaBloc extends Bloc<ListSverkaEvent, ListSverkaState>{
  
  final _listSverkaRepository = ListSverkaRepository();

  ListSverkaBloc() : super(ListSverkaInitial(listSverka:[]));


  @override
  Stream<ListSverkaState> mapEventToState(
    ListSverkaEvent event,
  ) async* {
    if (event is Init) {
      yield* mapSverkaInitToState(event);
    } if(event is Del){
      yield* mapSverkaDelToState(event);
    }
  }

  Stream<ListSverkaState> mapSverkaInitToState(event) async* {
    yield ListSverkaLoading();
    Map idp = event.idp;
    print("startCity: ${idp['idAgent']}" );
    try {
          Map getListSverka = await _listSverkaRepository.getListSverkaApi(idp);
                  if(getListSverka['status']){
                      yield ListSverkaInitial(listSverka:getListSverka['listSverka']);
                  } 
                  else{
                     yield ListSverkaFailure(error: "Ошибка получения данных");
                  }
       
    } catch(e) {
      print("ERROR: $e");
      yield ListSverkaFailure(error: "Ошибка авторизации");
    }
  }

  Stream<ListSverkaState> mapSverkaDelToState(event) async* {
    yield ListSverkaLoading();
    try {
          bool result = await _listSverkaRepository.deleteSverka(event.id);
                if(result) {
                yield DelSverkaSuccess();
                }
                else{
                  yield DelSverkaFailure(error: "Ошибка");
                }
              
                  } catch(e) {
                    print("ERROR: $e");
                    yield DelSverkaFailure(error: "Ошибка");
                  }
  }
}
