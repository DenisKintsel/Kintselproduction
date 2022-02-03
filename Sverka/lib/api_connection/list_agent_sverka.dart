import 'dart:convert';
import 'package:http/http.dart' as http;

const url = '//////////////////';

final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

Future<Map> listAgentApi() async{

  // Starting Web API Call.
  var response = await http.post('$url/listAgent.php');

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> listSverkaApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/listSverka.php', body: json.encode(userSignUp));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}
Future<Map> deleteSverkaApi(deletesverka) async{

  // Starting Web API Call.
  var response = await http.post('$url/deletesverka.php', body: json.encode(deletesverka),headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}
Future<Map> deleteAgentApi(deleteAgent) async{

  // Starting Web API Call.
  var response = await http.post('$url/deleteAgent.php', body: json.encode(deleteAgent),headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}