// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {
  //designing header in login/signup
  String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
            headerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 40.0),
          ),
          SizedBox(height: 10.0),
          Image.asset(
            "assets/images/logo.png",
            height: 150.0,
            width: 150.0,
          ),
          SizedBox(height: 10.0),
          Text(
            'Dentist Care',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25.0),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
