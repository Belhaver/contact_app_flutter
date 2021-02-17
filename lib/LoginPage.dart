import 'dart:math';

import 'package:contact_app_flutter/AppConstans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Contact.dart';
import 'TestPage.dart';

class LoginPage extends StatelessWidget {

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> attemptAuthorization(String username, String password) async {

    final response = await http.post(
      Uri.http(AppConstans.baseUrl , "/login", {"username": username, "password": password} ),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200) {
      AppConstans.token = response.headers["authorization"];
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    left: 30, top: 70, right: 30, bottom: 50),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green[900]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.green[900],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 5
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, top: 50, right: 20, bottom: 20),
                      child: Text(
                        'contact-app',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0
                        ),),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 30, right: 20, bottom: 20),
                        child: TextField(
                          controller: _loginController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0)),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Username',
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 30, right: 20, bottom: 40),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0)),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                          ),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        margin: EdgeInsets.only(
                            left: 30, top: 0, right: 30, bottom: 0),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0))
                        ),
                        child: FlatButton(
                          onPressed: () async {
                            if(await (attemptAuthorization(_loginController.text, _passwordController.text))) {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ContactsPage(title: 'Kontakty')));
                            }
                          },
                          child: Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                              )
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 20, right: 20, bottom: 10),
                        child: FlatButton(
                            child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                )
                            )
                        )
                    )
                  ],
                ),
              ),
            ),
        ),
    );
  }
}