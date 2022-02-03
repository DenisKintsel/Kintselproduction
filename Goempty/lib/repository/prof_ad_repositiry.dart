import 'package:flutterapp2/api_connection/prof_ad_con.dart';

class ProfAdRepository{

Future<Map> getProfAdApi(idAS) async {
    Map respons = await profAdApi(idAS);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listprof = body['prof'];
    print('REP:$listprof');
    return {
        'status':status,
        'listprof':listprof
      };
    }
    else{
      return {
        'status':status,
        'listprof':[]
      };
    }
  }
}