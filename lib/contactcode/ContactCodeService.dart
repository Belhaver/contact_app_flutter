import 'package:contact_app_flutter/AppConstans.dart';
import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:http/http.dart' as http;

Future<String> getContactCode() async {
  final response = await http.post(
    Uri.http(AppConstans.baseUrl, '/api/contactCode/create'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization' : await getToken()
    },
  );

  if(response.statusCode == 200) {
    return response.body;
  } else {
    // error should be returned from the server and here you should parse it - similar comment should be added to method below
    return 'error';
  }
}

Future<bool> addContactWithCode(String codeValue) async {
  final response = await http.post(
    Uri.http(AppConstans.baseUrl, '/api/contacts/createContactWithCode', {"contactCodeValue": codeValue}),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': await getToken()
    },
  );

  if(response.statusCode == 200) {
    return true;
  }
  else {
    return false;
  }
}
