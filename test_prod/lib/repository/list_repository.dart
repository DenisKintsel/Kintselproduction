import '../api/api_list.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class ListRepository {
  Future<Map> getListApi() async {
    Map respons = await listApi();
    Map body = respons['body'];
    int status = respons['status'];
    if (status == 200) {
      var box = await Hive.openBox<dynamic>('testBox');
      await box.delete('title');
      await box.put('title', body['items']);
      List list = body['items'];
      print('REP:$list');
      return {'list': list};
    } else {
      return {'list': []};
    }
  }
}
