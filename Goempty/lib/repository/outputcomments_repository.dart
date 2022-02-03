import 'package:flutterapp2/api_connection/add_comments.dart';

class OutputCommentsRepository{

Future<Map> getOutputCommentsApi(searchid) async {
    Map respons = await outputCommentsApi(searchid);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listComments = body['com'];
    print('REP:$listComments');
    return {
        'status':status,
        'listCargo':listComments
      };
    }
    else{
      return {
        'status':status,
        'listComments':[]
      };
    }
  }
}