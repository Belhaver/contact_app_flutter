import 'package:contact_app_flutter/contactdetails/AddContactDetailsPage.dart';
import 'package:contact_app_flutter/customwidgets/AppTextFormWidget.dart';
import 'package:contact_app_flutter/login/LoginPage.dart';
import 'package:contact_app_flutter/login/LoginService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppUserService.dart';

class RegisterAppUserPage extends StatelessWidget {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _countryController = TextEditingController();

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
                      left: 20, top: 50, right: 20, bottom: 30),
                  child: Text(
                    'Sign up to application!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0
                    ),),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 10),
                    child: TextFormField(
                      controller: _usernameController,
                      validator: (_usernameController) {
                        if(_usernameController.isEmpty) {
                          return 'bad credentials';
                        } else {
                          return null;
                        }
                      },
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
                        left: 20, top: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: _passwordController,
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
                Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 40),
                    child: TextField(
                      controller: _countryController,
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
                        labelText: 'Country',
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 10),
                    margin: EdgeInsets.only(
                        left: 30, top: 0, right: 30, bottom: 40),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20.0))
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        if( await registerAppUser(_usernameController.text, _passwordController.text, _countryController.text)) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginPage()));
                        }
                      },
                      child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25
                          )
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class newRegisterAppUserPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RegisterAppUserState();
  }

}

class RegisterAppUserState extends State<newRegisterAppUserPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _countryController = TextEditingController();
  bool _isSomethingWentWrong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5
                        )
                      )
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.green[900]
                      ),
                    ),
                  ),
                  appTextFormWidget('username', _usernameController, 200),
                  appTextFormWidget('password', _passwordController, 200, obscureText: true),
                  appTextFormWidget('country', _countryController, 200),
                  Visibility(
                    visible: _isSomethingWentWrong,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 3, top: 15, right: 3, bottom: 5),
                      child: Text(
                        'Something went wrong. Try again',
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 30, top: 10, right: 30, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.green[900],
                          borderRadius: BorderRadius.all(
                              Radius.circular(3.0))
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          if( await registerAppUser(_usernameController.text, _passwordController.text, _countryController.text)) {
                            if(await attemptAuthorization(_usernameController.text, _passwordController.text)) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => NewAddContactDetailsPage()));
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => LoginPage()));
                            }
                          } else {
                            setState(() {
                              _isSomethingWentWrong = true;
                            });
                          }
                        },
                        child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                            )
                        ),
                      )
                  ),
                ],
              ),
          ),
      ),
    );
  }

}