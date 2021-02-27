
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appDataWidget(
    String labelText,
    String dataText,
    {double width = 200}
    ) {

  return Container(
    padding: EdgeInsets.only(
        left: 2.5, right: 5),
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Colors.grey,
                width: 0.5
            )
        )
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 45,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
              left: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      color: Colors.grey,
                      width: 0.5
                  )
              )
          ),
          child: Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            width: width,
            height: 45,
            padding: EdgeInsets.only(
                left: 15),
            child: Text(
              dataText,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            ),
      ],
    ),
  );
}