
import '../api_connection/add_agent_sverka.dart';

class AddSverkaRepository {
  //final UserPreferences userPreferences = UserPreferences();

Future<bool> addSverka(String datego, String datefinish, String namber, String res, String note,String id) async{
    Map addSvrka = {'datego':datego, 'datefinish': datefinish, 'namber':namber, 'res': res, 'note': note, 'id':id};

    Map result = await addSverkaApi(addSvrka);
    int status = result['status'];
    Map body = result['body'];
    if(status == 200 && body['error'] == null)
    {
      print("SUCCESS");
      return body['status'];
    }
    else {
      print("FAIL");
      return body['status'];
    }
  }
  
Future<bool> editSverka(String namber, String res, String note,String id) async{
    Map editSverka = {'namber':namber, 'res': res, 'note': note, 'id':id};

    Map result = await editSverkaApi(editSverka);
    int status = result['status'];
    Map body = result['body'];
    if(status == 200 && body['error'] == null)
    {
      print("SUCCESS");
      return body['status'];
    }
    else {
      print("FAIL");
      return body['status'];
    }
  }
}