import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusinessesList extends StatefulWidget {
  @override
  _BusinessesListState createState() => _BusinessesListState();
}

class _BusinessesListState extends State<BusinessesList> {
  TextEditingController controller = new TextEditingController();
  String filter = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('businesses').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Expanded(
                  child: new ListView(
                    shrinkWrap: true,
                    children: snapshot.data.documents.where((document) {
                      return document['name'].toLowerCase().contains(filter.toLowerCase());
                    }).map((DocumentSnapshot document) {
                      return new ListTile(
                        title: new Text(document['name']),
                        subtitle: new Text(document['address']),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
