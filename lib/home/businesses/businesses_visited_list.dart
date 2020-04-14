import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coval/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusinessesVisitedList extends StatelessWidget {
  final User user;
  final Function updateFunction;

  const BusinessesVisitedList({Key key, this.user, this.updateFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(user.uid)
          .collection("responses")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            updateFunction(snapshot.data.documents.length);
            List<ListTile> tiles = snapshot.data.documents.length > 0
                ? snapshot.data.documents.map((DocumentSnapshot document) {
                  Timestamp timestamp = document['timestamp'];
                    return ListTile(
                      title: Text(document['businessName']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(document['businessAddress']),
                          Text(DateFormat.yMMMd().add_jm().format(DateTime.parse(timestamp.toDate().toString())).toString())
                        ],
                      ),
                    );
                  }).toList()
                : [];
            return ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: tiles,
            );
            Text("Didnt visit anywhere yet");
        }
      },
    );
  }
}
