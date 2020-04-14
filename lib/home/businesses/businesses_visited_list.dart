import 'package:coval/models/business_visit.dart';
import 'package:flutter/material.dart';

class BusinessesVisitedList extends StatelessWidget {
  final List<BusinessVisit> placesVisited;

  const BusinessesVisitedList({Key key, this.placesVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListTile> tiles = placesVisited.length > 0
        ? placesVisited.map((BusinessVisit businessVisit) {
            return ListTile(
              title: Text(businessVisit.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(businessVisit.address),
                  Text(businessVisit.timeStamp)
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
  }
}
