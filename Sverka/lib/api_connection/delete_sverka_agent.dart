import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://sverka.000webhostapp.com';

final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

/*Future<Map> addAgentrApi(userSignIn) async{

  // Starting Web API Call.
  var response = await http.post('$url/addagent.php', body: json.encode(userSignIn), headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}*/

Future<Map> deleteSverkaApi(deletesverka) async{

  // Starting Web API Call.
  var response = await http.post('$url/deletesverka.php', body: json.encode(deletesverka),headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}