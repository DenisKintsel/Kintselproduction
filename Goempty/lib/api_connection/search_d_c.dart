import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'http://78.107.58.201';

Future<Map> searchCargoApi(userSignIn) async{

  // Starting Web API Call.
  var response = await http.post('$url/vbn4.php', body: json.encode(userSignIn));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> searchDriverApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/listdriver.php', body: json.encode(userSignUp));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}