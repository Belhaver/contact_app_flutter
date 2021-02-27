import 'dart:async';
import 'dart:convert';

import 'package:contact_app_flutter/AppConstans.dart';
import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'Contact.dart';

Future<List<Contact>> fetchContacts(http.Client client) async {


  final response = await client.get(
      Uri.http(AppConstans.baseUrl, "/api/contacts/findUserContacts"),
      headers: <String, String> {
        'Authorization': await getToken()
      });

  return compute(parseContacts, response.body);
}

List<Contact> parseContacts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
}