import 'package:flutterapp2/api_connection/add_cargo_driver.dart';

class AddDriverRepository {
  //final UserPreferences userPreferences = UserPreferences();

Future<bool> addDriver(String city1, String city2, String car, String price, String phone,String note,String data,String id) async{
    Map addCargo = {'city1':city1, 'city2': city2, 'car':car, 'phone': phone, 'price': price,'id_user': id, 'note':note, 'data':data};

    Map result = await addDriverApi(addCargo);
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