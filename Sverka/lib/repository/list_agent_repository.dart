import '../api_connection/list_agent_sverka.dart';

class ListAgentRepository{

Future<Map> getListAgentApi() async {
    Map respons = await listAgentApi();
    Map body = respons['body'];
    bool status = body['status'];
    if(status){
      List listAgent = body['agent'];
    print('REP:$listAgent');
    return {
        'status':status,
        'listAgent':listAgent
      };
    }
    else{
      return {
        'status':status,
        'listAgent':[]
      };
    }
  }

Future<bool> getDelAgentApi(String id) async{
    Map deleteAgent = {'id':id};
    Map result = await deleteAgentApi(deleteAgent);
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