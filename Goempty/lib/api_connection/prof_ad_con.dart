import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'http://78.107.58.201';

Future<Map> profAdApi(userSignIn) async{

  // Starting Web API Call.
  var response = await http.post('$url/prof_ad.php', body: json.encode(userSignIn));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}
// Объявление выводятся в личном профиле
Future<Map> searchMyProfilAdApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/listdriver.php', body: json.encode(userSignUp));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}