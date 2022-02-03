import 'package:flutterapp2/api_connection/profile.dart';

class ProfileAuRepository{


Future<Map> getProfileApi(idAS) async {
    Map respons = await searchProfileApi(idAS);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listUserA = body['user'];
    print('REP:$listUserA');
    return {
        'status':status,
        'listUserA':listUserA
      };
    }
    else{
      return {
        'status':status,
        'listUserA':[]
      };
    }
  }
}
