import 'package:coval/home/user_profile.dart';
import 'package:coval/models/user.dart';
import 'package:coval/models/user_data.dart';
import 'package:coval/services/user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
        value: UserDatabaseService(uid: user.uid).userData,
        child: UserProfile());
  }
}
