import 'package:contact_app_flutter/AppConstans.dart';
import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:http/http.dart' as http;

//it should be a class ContactCodeService or ContactCodeApiClient

// you should add another layer between view (or presenter) and api client i.e. ContactCodeInteractor (please read what interactors should do). 
// This way you will implement code closer to SOLID principles. 
// ApiClient should just have methods below and interactor should wrap data you are getting into a form ready to save in database / display / etc

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
