import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp2/repository/cargo_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'cargo_event.dart';
part 'cargo_state.dart';

class CargoBloc extends Bloc<CargoEvent, CargoState>{
  
  final _cargoRepository = CargoRepository();

  CargoBloc() : super(CargoInitial(cargo:[]));


  @override
  Stream<CargoState> mapEventToState(
    CargoEvent event,
  ) async* {
    if (event is Init) {
      yield* mapCargoInitToState(event);
    }
  }

  Stream<CargoState> mapCargoInitToState(event) async* {
    yield CargoLoading();
    Map searchG = event.searchG;
    print("startCity: ${searchG['startCity']} endCity: ${searchG['endCity']}" );
    try {
          Map getCargo = await _cargoRepository.getCargoApi(searchG);
                   if(getCargo['status']){
                     if(getCargo['listCargo'].length==0){
                       yield CargoFailure(error: "Ничего не найдено");
                     }
                     else{
                      yield CargoInitial(cargo:getCargo['listCargo']);
                     }
                      }
                      else{
                        yield CargoFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield CargoFailure(error: "Ошибка авторизации");
    }
  }
}
