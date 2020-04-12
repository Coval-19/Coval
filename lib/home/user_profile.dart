import 'package:coval/loading/loading.dart';
import 'package:coval/models/user_data.dart';
import 'package:coval/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context) ?? null;

    return userData == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
                  onPressed: authService.signOut,
                )
              ],
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Hero(
                            tag: "user",
                            child: Container(
                              height: 96.0,
                              width: 96.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(userData.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(80.0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userData.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
