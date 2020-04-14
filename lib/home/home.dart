import 'package:coval/home/main_page.dart';
import 'package:coval/models/user.dart';
import 'package:coval/models/user_data.dart';
import 'package:coval/services/user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
        value: UserDatabaseService(uid: user.uid).userData,
        child: MainPage());
  }
}
