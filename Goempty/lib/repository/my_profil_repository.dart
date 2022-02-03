import 'package:flutterapp2/api_connection/profile.dart';

class MyProfilRepository{


Future<Map> getMyProfilApi(idMy) async {
    Map respons = await searchMyProfilApi(idMy);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listmyinf = body['myinfo'];
    print('REP:$listmyinf');
    return {
        'status':status,
        'listmyinf':listmyinf
      };
    }
    else{
      return {
        'status':status,
        'listmyinf':[]
      };
    }
  }
}
