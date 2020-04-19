import 'package:coval/models/business_data.dart';
import 'package:coval/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business_page.dart';

class BusinessesList extends StatefulWidget {
  @override
  _BusinessesListState createState() => _BusinessesListState();
}

class _BusinessesListState extends State<BusinessesList> {
  TextEditingController controller = new TextEditingController();
  UserData userData;
  String filter = "";

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<UserData>(context) ?? null;
    final businesses = Provider.of<List<BusinessData>>(context);
    List<Widget> tiles = businesses.length > 0
        ? businesses.where((business) {
            return business.name.toLowerCase().contains(filter.toLowerCase());
          }).map((business) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BusinessPage(businessData: business, userData: userData,)));
              },
              child: ListTile(
                title: Text(business.name),
                subtitle: Text(business.address),
              ),
            );
          }).toList()
        : [];
    return SafeArea(
      child: Column(
        children: <Widget>[
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
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: tiles,
            ),
          ),
        ],
      ),
    );
  }
}
