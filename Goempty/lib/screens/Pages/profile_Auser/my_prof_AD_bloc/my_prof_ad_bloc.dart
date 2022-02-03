import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterapp2/repository/my_profil_ad_repository.dart';
part 'my_prof_ad_event.dart';
part 'my_prof_ad_state.dart';

class MyProfAdBloc extends Bloc<MyProfAdEvent, MyProfAdState>{
  
  final _myprofAdRepository = MyProfilADRepository();

  MyProfAdBloc() : super(MyProfAdInitial(prof:[]));


  @override
  Stream<MyProfAdState> mapEventToState(
    MyProfAdEvent event,
  ) async* {
    if (event is MyProfAdInit) {
      yield* mapMyProfAdInitToState(event);
    }
  }

  Stream<MyProfAdState> mapMyProfAdInitToState(event) async* {
    yield MyProfAdLoading();
    Map idAS  = event.idAS;
    try {
          Map getMyProfAd = await _myprofAdRepository.getMyProfAdApi(idAS);
                   if(getMyProfAd['status']){
                     if(getMyProfAd['listprof'].length==0){
                      yield MyProfAdFailure(error: "Объявления не найдены");
                     }
                     else{
                         yield MyProfAdInitial(prof:getMyProfAd['listprof']);
                     }
                   } 
                      else{
                        yield MyProfAdFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield MyProfAdFailure(error: "Ошибка подключения");
    }
  }
}