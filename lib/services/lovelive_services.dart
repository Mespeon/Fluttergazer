import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:lovelive/model/sif_model.dart';

String url = 'https://marknolledo.pythonanywhere.com/sibyl/ionic/stargazer';

//Future<List<Stargazer>> getAllMembers() async {
//  final response = await http.get(url);
//  print(response.body);
//  return stargazerFromJson(response.body);
//}

Future<Stargazer> getMembers() async {
  final response = await http.get(url);
  return stargazerFromJson(response.body);
}