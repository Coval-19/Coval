import 'package:coval/authenticate/authenticate.dart';
import 'package:coval/home/home_page.dart';
import 'package:coval/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
