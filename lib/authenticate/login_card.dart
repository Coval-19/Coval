import 'package:coval/authenticate/validation.dart';
import 'package:coval/services/auth_service.dart';
import 'package:coval/services/exceptions/login_exception.dart';
import 'package:flutter/material.dart';

class LogInCard extends StatefulWidget {
  final Function authModeChange;
  final Function setLoading;
  final Function setError;
  final Function getError;

  const LogInCard(
      {Key key,
      this.authModeChange,
      this.setLoading,
      this.setError,
      this.getError})
      : super(key: key);

  @override
  _LogInCardState createState() =>
      _LogInCardState(authModeChange, setLoading, getError, setError);
}

class _LogInCardState extends State<LogInCard> {
  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  final Function authModeChange;
  final Function setLoading;
  final Function setError;
  final Function getError;

  String _email;
  String _password;

  _LogInCardState(
      this.authModeChange, this.setLoading, this.getError, this.setError);

  void onLogIn() async {
    if (_formKey.currentState.validate()) {
      setLoading(true);
      try {
        await authService.signIn(_email.trim(), _password.trim());
      } on LoginException catch (e) {
        setError(e.message);
        setLoading(false);
      }
      print("email:$_email, password:$_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                    SizedBox(height: 12.0),
                    Text(
                      getError(),
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
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
