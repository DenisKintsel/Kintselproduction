import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../repository/list_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final _listPokeRepository = ListRepository();

  ListBloc() : super(ListInitial(list: const []));

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    if (event is Init) {
      yield* mapListInitToState();
    }
  }

  Stream<ListState> mapListInitToState() async* {
    yield ListLoading();
    if (await InternetConnectionChecker().hasConnection == true) {
      try {
        Map getListAgent = await _listPokeRepository.getListApi();
        if (getListAgent['list'].length == 0) {
          yield ListFailure(error: "Ничего не найдено");
        } else {
          yield ListInitial(list: getListAgent['list']);
        }
      } catch (e) {
        print("ERROR : $e");
        yield ListFailure(error: "Ничего не найдено");
      }
    } else {
      var box = await Hive.openBox<dynamic>('testBox');
      final list2 = box.get('title');
      List name = list2;
      yield ListBD(name: name);
    }
    /*try {
      print("ПРошел дальше");
      Map getListAgent = await _listPokeRepository.getListApi();
      if (getListAgent['list'].length == 0) {
        yield ListFailure(error: "Ничего не найдено");
      } else {
        yield ListInitial(list: getListAgent['list']);
      }
    } catch (e) {
      print("ERROR : $e");
      var box = await Hive.openBox<dynamic>('testBox');
      final list2 = box.get('title');
      List name = list2;
      yield ListBD(name: name);
    }*/
  }
}
