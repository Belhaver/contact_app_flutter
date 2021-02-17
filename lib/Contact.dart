import 'dart:async';
import 'dart:convert';

import 'package:contact_app_flutter/AppConstans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<Contact>> fetchContacts(http.Client client) async {
  final response = await client.get(
    Uri.http(AppConstans.baseUrl, "/api/contacts/findUserContacts"),
    headers: <String, String> {
      'Authorization' : AppConstans.token
    });
    return compute(parseContacts, response.body);
}

List<Contact> parseContacts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
}

class Contact {
  final int id;
  final Recipent recipent;
  final bool favourite;
  final bool hide;
  final String note;
  final String createdAt;

  Contact({this.id, this.recipent, this.favourite, this.hide, this.note, this.createdAt});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as int,
      recipent: Recipent.fromJson(json['recipent']),
      favourite: json['favourite'] as bool,
      hide: json['hide'] as bool,
      createdAt: json['createdAt'] as String
    );
  }
}

class Recipent {
  final int id;
  final String name;
  final String lastname;
  final String telephoneNumber;
  final String email;
  final String company;
  final String companyAdress;
  final String imageUrl;
  final String position;
  final String positionEN;

  Recipent({
      this.id,
      this.name,
      this.lastname,
      this.telephoneNumber,
      this.email,
      this.company,
      this.companyAdress,
      this.imageUrl,
      this.position,
      this.positionEN});

  factory Recipent.fromJson(Map<String, dynamic> json) {
    return Recipent(
        id: json['id'] as int,
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        telephoneNumber: json['telephoneNumber'] as String,
        email: json['email'] as String,
        company: json['company'] as String,
        companyAdress: json['companyAdress'] as String,
        imageUrl: json['imageUrl'] as String,
        position: json['position'] as String,
        positionEN: json['positionEN'] as String);
  }
}

class ContactsPage extends StatelessWidget {

  final String title;

  ContactsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green[900],
      ),
      body: FutureBuilder<List<Contact>>(
        future: fetchContacts(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ContactsList(contacts: snapshot.data)
              : Center(child: CircularProgressIndicator(backgroundColor: Colors.green[900],));
        },
      ),
    );
  }
}

class ContactsList extends StatelessWidget {

  final List<Contact> contacts;

  ContactsList({Key key, this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(
              left: 10, top: 10, right: 10, bottom: 10),
          margin: EdgeInsets.only(
              left: 10, top: 10, right: 10, bottom: 0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green[900]),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0))
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        contacts[index].recipent.name + " " + contacts[index].recipent.lastname,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                         fontSize: 20,
                          fontWeight: FontWeight.w900
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      contacts[index].recipent.position,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        contacts[index].recipent.company,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                  ),
                  Container(
                    width: 70,
                      padding: EdgeInsets.only(
                          left: 5, top: 5, right: 5, bottom: 5),
                      margin: EdgeInsets.only(
                          top: 3, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green[900]),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0))
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Icon(
                        Icons.star_outline
                      ),
                      Icon(
                        Icons.remove_red_eye_outlined
                      )
                    ],)
                  )
                ],
            ),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(
                      bottom: 5),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green[900]),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0))
                    ),
                    child: Center(
                      child: Text(
                      'image',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    ),
                  )
                  )
                ],
              )
            ],
            ),
        );
      },
    );
  }

}