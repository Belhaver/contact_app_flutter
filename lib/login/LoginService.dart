import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:http/http.dart' as http;

import '../AppConstans.dart';


Future<bool> attemptAuthorization(String username, String password) async {

  final response = await http.post(
    Uri.http(AppConstans.baseUrl , "/login", {"username": username, "password": password} ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if(response.statusCode == 200) {
    await saveToken(response.headers["authorization"]);
    return true;
  }
  return false;
}
