import 'package:http/http.dart' as http;
import 'package:fluttergazer/model/auth_model.dart';
import 'dart:async';
import 'dart:io';

import 'package:fluttergazer/model/sif_model.dart';

String url = 'https://marknolledo.pythonanywhere.com/sibyl/ionic/stargazer';
String boilnierplate = 'https://boilnierplate-backend.glitch.me/';

//Future<List<Stargazer>> getAllMembers() async {
//  final response = await http.get(url);
//  print(response.body);
//  return stargazerFromJson(response.body);
//}

// Stargazer Member Retrieval
Future<Stargazer> getMembers() async {
  final response = await http.get(url);
  return stargazerFromJson(response.body);
}

// Boilnierplate login auth + registration
Future<http.Response> login(action, data) async {
  print(action);
  var nierplate = boilnierplate;
  if (action == 'login') {
    nierplate += 'api/auth';
  }
  else if (action == 'register') {
    nierplate += 'api/user';
  }

  final response = await http.post(
    nierplate,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: loginToJson(data)
  );

  if (response.statusCode < 200 || response.statusCode > 400) {
    throw new Exception('Something went wrong with the request.');
  }
  else {
    return response;
  }
}

// Boilnierplate retrieve data
// Future<void> retrieve() async {

// }