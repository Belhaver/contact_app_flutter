import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Contact.dart';
import 'ContactsService.dart';

class ContactsPage extends StatefulWidget {

  ContactsPage({Key key}) : super(key: key);

  @override
  State<ContactsPage> createState() {
    return ContactsState();
  }

}

class ContactsState extends State<ContactsPage> {

  Future<List<Contact>> _futureContacts;

  @override
  void initState()  {
    super.initState();
    _futureContacts = fetchContacts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
            'contact-app',
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 25
          ),
        ),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _futureContacts,
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
                              Icons.visibility
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