

import 'package:contact_app_flutter/contactdetails/ContactDetails.dart';
import 'package:contact_app_flutter/contactdetails/ContactDetailsService.dart';
import 'package:contact_app_flutter/customwidgets/AppDataWidget.dart';
import 'package:contact_app_flutter/login/LoginPage.dart';
import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactDetailsState();
  }
}

class ContactDetailsState extends State<ContactDetailsPage> {

  Future<ContactDetails> _futureContactDetails;

  @override
  void initState() {
    super.initState();
    _futureContactDetails = fetchContactDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'contact details',
          style: TextStyle(
              color: Colors.green[900],
              fontSize: 25
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                deleteToken();
              },
              child: Text(
                'logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15
                ),
              ))
        ],
      ),
      body: Center(
        child: FutureBuilder<ContactDetails>(
          future: _futureContactDetails,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey,
                            width: 0.5
                        )
                    )
                ),
                child: Column(
                  children: [
                    appDataWidget('Name', snapshot.data.name),
                    appDataWidget('Lastname', snapshot.data.lastname),
                    appDataWidget('Telephone number', snapshot.data.telephoneNumber),
                    appDataWidget('E-mail', snapshot.data.email),
                    appDataWidget('Company', snapshot.data.company),
                    appDataWidget('Company adress', snapshot.data.companyAdress),
                    appDataWidget('Position', snapshot.data.position),
                    appDataWidget('Position EN', snapshot.data.positionEN),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

}


