import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp2/repository/driver_repository.dart';
import 'package:equatable/equatable.dart';

part 'driver_event.dart';
part 'driver_state.dart';


class DriverBloc extends Bloc<DriverEvent, DriverState>{
  
  final _driverRepository = DriverRepository();

  DriverBloc() : super(DriverInitial(driver:[]));


  @override
  Stream<DriverState> mapEventToState(
    DriverEvent event,
  ) async* {
    if (event is Init) {
      yield* mapCargoInitToState(event);
    }
  }

  Stream<DriverState> mapCargoInitToState(event) async* {
    yield DriverLoading();
    Map searchD = event.searchD;
    print("startCity: ${searchD['startCity']} endCity: ${searchD['endCity']}" );
    try {
          Map getDriver = await _driverRepository.getDriverApi(searchD);
                  if(getDriver['status']){
                      yield DriverInitial(driver:getDriver['listDriver']);
                  } 
                  else{
                     yield DriverFailure(error: "Ошибка получения данных");
                  }
       
    } catch(e) {
      print("ERROR: $e");
      yield DriverFailure(error: "Ошибка авторизации");
    }
  }
}
