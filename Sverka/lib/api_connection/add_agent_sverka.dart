import 'dart:convert';
import 'package:http/http.dart' as http;

const url = '///////////////////';

final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

Future<Map> addAgentrApi(userSignIn) async{

  // Starting Web API Call.
  var response = await http.post('$url/addagent.php', body: json.encode(userSignIn), headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> addSverkaApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/addsverka.php', body: json.encode(userSignUp),headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> editSverkaApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/editsverka.php', body: json.encode(userSignUp),headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}