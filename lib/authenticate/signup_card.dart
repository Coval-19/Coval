import 'dart:io';

import 'package:coval/authenticate/validation.dart';
import 'package:coval/services/auth_service.dart';
import 'package:coval/services/exceptions/registration_exception.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpCard extends StatefulWidget {
  final double screenHeight;
  final Function authModeChange;
  final Function setLoading;
  final Function setError;
  final Function getError;

  const SignUpCard(
      {Key key,
      this.screenHeight,
      this.authModeChange,
      this.setLoading,
      this.setError,
      this.getError})
      : super(key: key);

  @override
  _SignUpCardState createState() => _SignUpCardState(
      screenHeight, authModeChange, setLoading, setError, getError);
}

class _SignUpCardState extends State<SignUpCard> {
  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  final double screenHeight;
  final Function authModeChange;
  final Function setLoading;
  final Function setError;
  final Function getError;

  File _pickedImage;
  String _name;
  String _socialNumber;
  String _email;
  String _password;

  _SignUpCardState(this.screenHeight, this.authModeChange, this.setLoading,
      this.setError, this.getError);

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file =
          await ImagePicker.pickImage(source: imageSource, imageQuality: 85);
      if (file != null) {
        setState(() => _pickedImage = file);
      }
    }
  }

  void onSignUp() async {
    if (_pickedImage == null) {
      setError("Please upload an image");
      return;
    }

    if (_formKey.currentState.validate()) {
      setLoading(true);
      try {
        await authService.registerUser(_email.trim(), _password.trim(), _name,
            _socialNumber, _pickedImage);
      } on RegistrationException catch (e) {
        setError(e.message);
        setLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
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
                        "Create Account",
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
                    _pickedImage == null
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Row(children: [
                              Text("Upload Image",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey[600])),
                              IconButton(
                                icon: Icon(Icons.add_a_photo),
                                onPressed: _pickImage,
                              )
                            ]),
                          )
                        : Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("User Image",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[600]))),
                              GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                    backgroundImage: FileImage(_pickedImage),
                                    radius: 60.0,
                                    child: Align(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                      alignment: Alignment.bottomRight,
                                    )),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Your Social Id",
                            hasFloatingPlaceholder: true),
                        validator: (value) {
                          return value.isEmpty ? "*Required" : null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _socialNumber = value;
                          });
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Your Name",
                            hasFloatingPlaceholder: true),
                        validator: (value) {
                          return value.isEmpty ? "*Required" : null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        }),
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
                        }),
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
                    Text(
                      "Password must be at least 8 characters and include a special character and number",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      getError(),
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          child: Text("Sign Up"),
                          color: Color(0xFF4B9DFE),
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: onSignUp,
                        ),
                      ],
                    ),
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
              "Already have an account?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: authModeChange,
              textColor: Colors.black87,
              child: Text("Login"),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
