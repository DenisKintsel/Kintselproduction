import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterapp2/repository/profile_au_repository.dart';
import 'package:equatable/equatable.dart';
part 'profile_au_event.dart';
part 'profile_au_state.dart';

class ProfileAuBloc extends Bloc<ProfileAuEvent, ProfileAuState>{
  
  final _profileAuRepository = ProfileAuRepository();

  ProfileAuBloc() : super(ProfileAuInitial(userA:[]));


  @override
  Stream<ProfileAuState> mapEventToState(
    ProfileAuEvent event,
  ) async* {
    if (event is Init) {
      yield* mapProfileAuInitToState(event);
    }
  }

  Stream<ProfileAuState> mapProfileAuInitToState(event) async* {
    yield ProfileAuLoading();
    Map idAS  = event.idAS;
    try {
          Map getProfileAu = await _profileAuRepository.getProfileApi(idAS);
                   if(getProfileAu['status']){
                      yield ProfileAuInitial(userA:getProfileAu['listUserA']);
                      }
                      else{
                        yield ProfileAuFailure(error: "Ошибка получения данных");
                      }
       
    } catch(e) {
      print("ERROR: $e");
      yield ProfileAuFailure(error: "Ошибка авторизации");
    }
  }
}
