import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterapp2/repository/prof_ad_repositiry.dart';
part 'prof_ad_event.dart';
part 'prof_ad_state.dart';

class ProfAdBloc extends Bloc<ProfAdEvent, ProfAdState>{
  
  final _profAdRepository = ProfAdRepository();

  ProfAdBloc() : super(ProfAdInitial(prof:[]));


  @override
  Stream<ProfAdState> mapEventToState(
    ProfAdEvent event,
  ) async* {
    if (event is ProfAdInit) {
      yield* mapProfAdInitToState(event);
    }
  }

  Stream<ProfAdState> mapProfAdInitToState(event) async* {
    yield ProfAdLoading();
    Map idAS  = event.idAS;
    try {
          Map getProfAd = await _profAdRepository.getProfAdApi(idAS);
                   if(getProfAd['status']){
                     if(getProfAd['listprof'].length==0){
                      yield ProfAdFailure(error: "Объявления не найдены");
                     }
                     else{
                         yield ProfAdInitial(prof:getProfAd['listprof']);
                     }
                   } 
                      else{
                        yield ProfAdFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield ProfAdFailure(error: "Ошибка подключения");
    }
  }
}