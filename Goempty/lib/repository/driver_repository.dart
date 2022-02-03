import 'package:flutterapp2/api_connection/search_d_c.dart';

class DriverRepository{

Future<Map> getDriverApi(searchG) async {
    Map respons = await searchDriverApi(searchG);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
       List listDriver = body['driver'];
      print('REP:$listDriver');
    return {
        'status':status,
        'listDriver':listDriver
      };
    }
    else{
      return {
        'status':status,
        'listDriver':[]
      };
    }
   
  }
}