import 'package:coval/loading/loading.dart';
import 'package:coval/models/business_visit.dart';
import 'package:coval/models/user.dart';
import 'package:coval/models/user_data.dart';
import 'package:coval/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'businesses/businesses_visited_list.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context) ?? null;
    final List<BusinessVisit> placesVisited = Provider.of<List<BusinessVisit>>(context);

    return userData == null
        ? Loading()
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Stay Safe ${userData.name.split(" ")[0]}!",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(userData.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 25.0),
                                Text("${placesVisited.length}"),
                                Text("places visited"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage:
                                      NetworkImage(userData.imageUrl),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Places Visited",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10.0),
                          Container(height:200.0,
                              child: BusinessesVisitedList(placesVisited: placesVisited,))
                        ],
                      ),
                    ),
                  ),
                Card(
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Settings",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: authService.signOut,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Log out",
                                        style: TextStyle(fontSize: 15.0)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
