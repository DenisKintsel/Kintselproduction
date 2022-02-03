import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterapp2/repository/my_profil_repository.dart';
import 'package:equatable/equatable.dart';
part 'my_profil_event.dart';
part 'my_profil_state.dart';
class MyProfilBloc extends Bloc<MyProfilEvent, MyProfilState>{
  
  final _myprofilRepository = MyProfilRepository();

  MyProfilBloc() : super(MyProfilInitial(myinf:[]));


  @override
  Stream<MyProfilState> mapEventToState(
    MyProfilEvent event,
  ) async* {
    if (event is Initt) {
      yield* mapProfileAuInitToState(event);
    }
  }

  Stream<MyProfilState> mapProfileAuInitToState(event) async* {
    yield MyProfilLoading();
    Map idMy  = event.idMy;
    try {
          Map getMyProfil = await _myprofilRepository.getMyProfilApi(idMy);
                   if(getMyProfil['status']){
                      yield MyProfilInitial(myinf:getMyProfil['listmyinf']);
                      }
                      else{
                        yield MyProfilFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield MyProfilFailure(error: "Ошибка соединения");
    }
  }
}