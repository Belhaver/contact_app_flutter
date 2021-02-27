import 'dart:convert';
import '../AppConstans.dart';
import 'package:http/http.dart' as http;

Future<bool> registerAppUser(String username, String password, String country) async {
  final response = await http.post(
      Uri.http(AppConstans.baseUrl, "/api/users/add"),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'username': username,
        'password': password,
        'country': country
      })
  );
  print(response.statusCode);

  if(response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}