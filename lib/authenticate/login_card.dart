import 'package:coval/authenticate/validation.dart';
import 'package:flutter/material.dart';

class LogInCard extends StatefulWidget {
  final double screenHeight;
  final Function authModeChange;

  const LogInCard({Key key, this.screenHeight, this.authModeChange})
      : super(key: key);

  @override
  _LogInCardState createState() =>
      _LogInCardState(screenHeight, authModeChange);
}

class _LogInCardState extends State<LogInCard> {
  final _formKey = GlobalKey<FormState>();
  final double screenHeight;
  final Function authModeChange;

  String _email;
  String _password;

  _LogInCardState(this.screenHeight, this.authModeChange);

  void onLogIn() {
    if (_formKey.currentState.validate()) {
      print("email:$_email, password:$_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Your Email",
                          hasFloatingPlaceholder: true),
                      validator: emailValidator,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hasFloatingPlaceholder: true),
                        validator: passwordValidator,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {},
                          child: Text("Forgot Password ?"),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text("Login"),
                          color: Color(0xFF4B9DFE),
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: onLogIn,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: authModeChange,
              textColor: Colors.black87,
              child: Text("Create Account"),
            )
          ],
        )
      ],
    );
  }
}
