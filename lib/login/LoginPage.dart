
import 'package:contact_app_flutter/appuser/RegisterAppUserPage.dart';
import 'package:contact_app_flutter/customwidgets/AppTextFormWidget.dart';
import 'package:flutter/material.dart';

import '../home/Home.dart';
import '../TestPage.dart';
import 'LoginService.dart';


  class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
    }
  }


  class LoginPageState extends State<LoginPage> {

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isIncorrectCredentials = false;

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
                        // zmienić na TextFormField i dodać validator
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
                            left: 20, top: 30, right: 20, bottom: 10),
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
                    Visibility(
                      visible: _isIncorrectCredentials,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 3, top: 3, right: 3, bottom: 3),
                        margin: EdgeInsets.only(
                            left: 30, top: 3, right: 30, bottom: 3),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                                Radius.circular(3.0))
                        ),
                        child: Text(
                            'Incorrect username or password',
                            style: TextStyle(
                              color: Colors.white
                            ),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        margin: EdgeInsets.only(
                            left: 30, top: 10, right: 30, bottom: 0),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0))
                        ),
                        child: FlatButton(
                          onPressed: () async {
                            if(await (attemptAuthorization(_loginController.text, _passwordController.text))) {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                            } else {
                              setState(() {
                                _isIncorrectCredentials = true;
                              });
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
                            left: 20, top: 10, right: 20, bottom: 10),
                        child: FlatButton(
                          onPressed: () async => {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => TestPage()))
                          },
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

class LoginState extends State<LoginPage> {

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isIncorrectCredentials = false;
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                  margin: EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 30, right: 10, bottom: 10),
                      child: Text(
                          'contact-app',
                          style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 50
                          ),
                      ),
                  ),
                  Container(
                     margin: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                      child: Column(
                        children: [
                          appTextFormWidget('username', _loginController, 200,),
                          appTextFormWidget('password', _passwordController, 200, obscureText: true,)
                        ],
                      ),
                  ),
                  Visibility(
                    visible: _isIncorrectCredentials,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 3, top: 5, right: 3, bottom: 5),
                      child: Text(
                        'Incorrect username or password',
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
                          if(await (attemptAuthorization(_loginController.text, _passwordController.text))) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                          } else {
                            setState(() {
                              _isIncorrectCredentials = true;
                            });
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
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => newRegisterAppUserPage()));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      )
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

}