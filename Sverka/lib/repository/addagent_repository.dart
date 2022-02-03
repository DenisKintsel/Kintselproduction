

import '../api_connection/add_agent_sverka.dart';

class AddAgentRepository {

Future<bool> addAgent(String name, String inn, String kpp,String note) async{
    Map addAgent = {'name':name, 'inn': inn, 'kpp':kpp,'note':note};

    Map result = await addAgentrApi(addAgent);
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