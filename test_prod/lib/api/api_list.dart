import 'dart:convert';
import 'package:http/http.dart' as http;

//const url = 'https://pokeapi.co';

final Map<String, String> headers = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Future<Map> listApi() async {
  // Starting Web API Call.
  var response =
      await http.get('https://imdb-api.com/en/API/Top250Movies/k_uggthrbj');

  print(
      "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {
    'status': response.statusCode,
    'body': json.decode(response.body)
  };

  return result;
}
