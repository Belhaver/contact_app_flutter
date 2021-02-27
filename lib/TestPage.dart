
import 'package:contact_app_flutter/AppConstans.dart';
import 'package:contact_app_flutter/customwidgets/AppTextFormWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TestPage extends StatelessWidget {

  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _telephoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _companyAdressController = TextEditingController();
  final _positionController = TextEditingController();
  final _positionENController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 366,
          width: 290,
          margin: EdgeInsets.only(
              left: 10, top: 10, right: 10, bottom: 0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0))
          ),
          child: Center(
            child: Column(
              children: [
                // newAppTextFormWidget('login', _nameController, 200),
                // newAppTextFormWidget('password', _nameController, 200),
                // newAppTextFormWidget('email', _nameController, 200),
                // newAppTextFormWidget('company adress', _nameController, 200),
                // newAppTextFormWidget('company', _nameController, 200),
                // newAppTextFormWidget('position', _nameController, 200),
                // newAppTextFormWidget('phone number', _nameController, 200),
                // newAppTextFormWidget('gender', _nameController, 200),

              ],
            )
            ),
        ),
      )
    );
  }

}