import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'http://78.107.58.201';

final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

Future<Map> addCommentsApi(userSignIn) async{

  // Starting Web API Call.
  var response = await http.post('$url/addcomments.php', body: json.encode(userSignIn), headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> outputCommentsApi(userSignUp) async{

  // Starting Web API Call.
  var response = await http.post('$url/outputcomments.php', body: json.encode(userSignUp),headers: headers);

  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}