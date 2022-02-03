import '../api_connection/list_agent_sverka.dart';

class ListSverkaRepository{

Future<Map> getListSverkaApi(idp) async {
    Map respons = await listSverkaApi(idp);
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listSverka = body['sverka'];
    print('REP:$listSverka');
    return {
        'status':status,
        'listSverka':listSverka
      };
    }
    else{
      return {
        'status':status,
        'listSverka':[]
      };
    }
  }
Future<bool> deleteSverka(String id) async{
    Map deleteSverka = {'id':id};
    Map result = await deleteSverkaApi(deleteSverka);
    int status = result['status'];
    Map body = result['body'];
    if(status == 200 && body['error'] == null)
    {
      print("SUCCESS");
      return body['status'];

    }
    else {
      print("FAIL");
      return  body['status'];
    }
  }

}