import 'package:contact_app_flutter/contactcode/ContactCodePage.dart';
import 'package:contact_app_flutter/contactdetails/AddContactDetailsPage.dart';
import 'package:contact_app_flutter/contactdetails/ContactDetailsPage.dart';
import 'package:contact_app_flutter/contacts/ContactsPage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  final List<Widget> _children = [
    ContactsPage(),
    ContactCodePage(),
    ContactDetailsPage()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'User'
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
    );
  }
}