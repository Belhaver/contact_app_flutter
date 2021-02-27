import 'package:contact_app_flutter/customwidgets/AppTextFormWidget.dart';
import 'package:contact_app_flutter/home/Home.dart';
import 'package:contact_app_flutter/login/LoginPage.dart';
import 'package:contact_app_flutter/security/TokenRepository.dart';
import 'package:flutter/material.dart';

import '../AppConstans.dart';
import 'ContactDetailsService.dart';

class NewAddContactDetailsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AddContactDetailsState();
  }
}

class AddContactDetailsState extends State<NewAddContactDetailsPage> {

  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _telephoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _companyAdressController = TextEditingController();
  final _positionController = TextEditingController();
  final _positionENController = TextEditingController();

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
                  'Enter your contact details',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.green[900]
                  ),
                ),
              ),
                appTextFormWidget('Name', _nameController, 200),
                appTextFormWidget('Lastname', _lastnameController, 200),
                appTextFormWidget('Telephone number', _telephoneNumberController, 200),
                appTextFormWidget('E-mail', _emailController, 200),
                appTextFormWidget('Company', _companyController, 200),
                appTextFormWidget('Company adress', _companyAdressController, 200),
                appTextFormWidget('Position', _positionController, 200),
                appTextFormWidget('Position EN', _positionENController, 200),
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
                      if(await addContactDetails(
                            _nameController.text,
                            _lastnameController.text,
                            _telephoneNumberController.text,
                            _emailController.text,
                            _companyController.text,
                            _companyAdressController.text,
                            _positionController.text,
                            _positionENController.text)) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                        } else {
                        setState(() {
                          _isSomethingWentWrong = true;
                        });
                      }
                    },
                    child: Text(
                        'Save',
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