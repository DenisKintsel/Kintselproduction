import 'package:flutterapp2/api_connection/search_d_c.dart';

class CargoRepository{

Future<Map> getCargoApi(searchG) async {
    Map respons = await searchCargoApi(searchG);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listCargo = body['gryz'];
    print('REP:$listCargo');
    return {
        'status':status,
        'listCargo':listCargo
      };
    }
    else{
      return {
        'status':status,
        'listCargo':[]
      };
    }
  }
}