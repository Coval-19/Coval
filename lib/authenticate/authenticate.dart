import 'package:coval/authenticate/login_card.dart';
import 'package:coval/authenticate/signup_card.dart';
import 'package:flutter/material.dart';

enum AuthMode { LOGIN, SINGUP }

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  double screenHeight;
  AuthMode _authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            lowerHalf(context),
            upperHalf(context),
            _authMode == AuthMode.LOGIN
                ? LogInCard(
                screenHeight: screenHeight,
                authModeChange: () {
                  setState(() {
                    _authMode = AuthMode.SINGUP;
                  });
                })
                : SignUpCard(
                screenHeight: screenHeight,
                authModeChange: () {
                  setState(() {
                    _authMode = AuthMode.LOGIN;
                  });
                }),
            pageTitle(),
          ],
        ),
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.whatshot,
            size: 48,
            color: Colors.white,
          ),
          Text(
            "Coval",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Container(
        height: screenHeight / 2,
        color: Colors.blue,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }
}
