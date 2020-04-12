import 'dart:io';

import 'package:coval/models/user.dart';
import 'package:coval/services/exceptions/login_exception.dart';
import 'package:coval/services/exceptions/registration_exception.dart';
import 'package:coval/services/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future registerUser(String email, String password, String name, String socialNumber, File image) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await UserDatabaseService(uid: user.uid).updateUserData(name , socialNumber, image);
      return user;
    } catch (error) {
      print(error);
      print(error.code);
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          {
            throw RegistrationException(message: "Email already in use");
          }
        default:
          {
            throw RegistrationException(message: "Unkown Error");
          }
      }
    }
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.code);
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            throw LoginException(message: "User not registered");
          }
        case "ERROR_WRONG_PASSWORD":
          {
            throw LoginException(message: "Wrong Password");
          }
        default:
          {
            throw LoginException(message: "Unkown Error");
          }
      }
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
