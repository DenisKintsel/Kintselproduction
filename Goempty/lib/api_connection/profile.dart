import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'http://78.107.58.201';

Future<Map> searchProfileApi(userSignIn) async{

  // Starting Web API Call.
  var response = await http.post('$url/profile_au.php', body: json.encode(userSignIn));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> searchMyProfilApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/my_profil.php', body: json.encode(userSignUp));

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}