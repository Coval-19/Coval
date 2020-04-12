import 'package:coval/authenticate/login_card.dart';
import 'package:coval/authenticate/signup_card.dart';
import 'package:coval/loading/loading.dart';
import 'package:flutter/material.dart';

enum AuthMode { LOGIN, SINGUP }

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  double screenHeight;
  AuthMode _authMode = AuthMode.LOGIN;

  bool _loading = false;
  String _error = "";

  void setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  void setError(String error) {
    setState(() {
      _error = error;
    });
  }

  String getError() {
    return _error;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.amber,
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  upperHalf(context),
                  _authMode == AuthMode.LOGIN
                      ? LogInCard(
                          screenHeight: screenHeight,
                          authModeChange: () {
                            setState(() {
                              _authMode = AuthMode.SINGUP;
                              _error = "";
                            });
                          },
                          setLoading: setLoading,
                          setError: setError,
                          getError: getError)
                      : SignUpCard(
                          screenHeight: screenHeight,
                          authModeChange: () {
                            setState(() {
                              _authMode = AuthMode.LOGIN;
                              _error = "";
                            });
                          },
                          setLoading: setLoading,
                          setError: setError,
                          getError: getError),
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
          Image.asset("assets/coval-logo.jpeg", height: 100, width: 100),
        ],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(color: Colors.grey[100], height: screenHeight / 2);
  }
}
