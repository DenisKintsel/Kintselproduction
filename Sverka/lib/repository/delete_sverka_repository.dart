import '../api_connection/delete_sverka_agent.dart';

class DeleteSverkaRepository {
  //final UserPreferences userPreferences = UserPreferences();

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