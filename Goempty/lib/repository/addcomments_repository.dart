import 'package:flutterapp2/api_connection/add_comments.dart';

class AddCommentsRepository {
  //final UserPreferences userPreferences = UserPreferences();

Future<bool> addComments(String idusers, String iduserA, String comments,String star) async{
    Map addComments = {'idusers':idusers, 'iduserA': iduserA, 'comments': comments,'star': star};

    Map result = await addCommentsApi(addComments);
    int status = result['status'];
    Map body = result['body'];
    if(status == 200 && body['error'] == null)
    {
      print("SUCCESS");
    //  userPreferences.savePref('auth', true);
      return true;
    }
    else {
      print("FAIL");
      return false;
    }
  }
}