
import 'package:flutterapp2/api_connection/add_cargo_driver.dart';

class AddCargoRepository {
  //final UserPreferences userPreferences = UserPreferences();

Future<bool> addCargo(String city1, String city2, String cargo, String price, String phone,String note,String id) async{
    Map addCargo = {'pynktA':city1, 'pynktB': city2, 'vid':cargo, 'phone': phone, 'price': price,'id_user': id, 'note':note};

    Map result = await addCargoApi(addCargo);
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