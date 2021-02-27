import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../AppConstans.dart';
import 'ContactDetails.dart';

Future<bool> addContactDetails(
    String name,
    String lastname,
    String telephoneNumber,
    String email,
    String company,
    String companyAdress,
    String position,
    String positionEN
    ) async {
  final response = await http.post(
      Uri.http(AppConstans.baseUrl, "/api/contactsdetails/add"),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : await getToken()
      },
      body: jsonEncode(<String, String> {
        'name': name,
        'lastname': lastname,
        'telephoneNumber': telephoneNumber,
        'email': email,
        'company': company,
        'companyAdress': companyAdress,
        'position': position,
        'positionEN': positionEN
      })
  );

  if(response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<ContactDetails> fetchContactDetails() async {

  final response = await http.get(
    Uri.http(AppConstans.baseUrl, "/api/contactsdetails/findUserContactDetails"),
    headers: <String, String> {
    'Authorization': await getToken()
    });

    if(response.statusCode == 200) {
      return ContactDetails.fromJson(jsonDecode(response.body));
    }
  }