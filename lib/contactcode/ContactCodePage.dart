import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'ContactCodeService.dart';

class ContactCodePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ContactCodeState();
  }
}

class ContactCodeState extends State<ContactCodePage> {

  final _codeController = TextEditingController();

  int codeLength = 0;

  bool _isCodeNotExist = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  left: 5, top: 5, right: 5, bottom: 10),
              child: Text(
                'Enter code:',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.green[900]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                textStyle: TextStyle(
                  fontSize: 25
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeColor: Colors.black,
                  selectedColor: Colors.amber,
                  inactiveColor: Colors.black
                ),
                keyboardType: TextInputType.number,
                onCompleted: (value) async {
                  if(await addContactWithCode(value)) {
                    HapticFeedback.heavyImpact();
                    newContactAlertDialog(context);
                  } else {
                    setState(() {
                      _isCodeNotExist = true;
                    });
                  }
                },
              ),
            ),
            Visibility(
              visible: _isCodeNotExist,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 3, top: 15, right: 3, bottom: 5),
                child: Text(
                  'Invalid code',
                  style: TextStyle(
                      color: Colors.red
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  left: 5, top: 5, right: 5, bottom: 10),
              child: Text(
                'or:',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.green[900]
                ),
              ),
            ),
            Container(
                width: 240,
                height: 50,
                margin: EdgeInsets.only(
                    left: 5, top: 0, right: 10, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                        Radius.circular(3.0))
                ),
                child: FlatButton(
                  onPressed: () {
                    createCodeAlertDialog(context);
                  },
                  child: Text(
                      'Get contact code',
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
    );
  }

  // consider making these methods private by adding _ at the start and add return type 
  createCodeAlertDialog(BuildContext context) async {
    String contactCode = await getContactCode();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: Center(child: Text('Your code:')),
          content: Text(contactCode.substring(0, 3) + ' ' + contactCode.substring(3, 6),
            textAlign: TextAlign.center,
            style: TextStyle(
                wordSpacing: 4,
                letterSpacing: 2,
                fontSize: 50,
                fontWeight: FontWeight.w900
            ),
          )
      );
    });
  }

  newContactAlertDialog(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Center(child: Text('Added successfully!')),
      );
    });
  }
}
