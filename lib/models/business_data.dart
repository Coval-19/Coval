import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessData {
  final String uid;
  final String address;
  final LatLng coordinates;
  final String name;
  final String description;

  BusinessData(this.uid, this.address, this.coordinates, this.name, this.description);

  factory BusinessData.fromFireStore(DocumentSnapshot documentSnapshot) {
    GeoPoint point = documentSnapshot.data["addressCoordinates"];
    return BusinessData(
        documentSnapshot.documentID,
        documentSnapshot.data["address"],
        LatLng(point.latitude, point.longitude),
        documentSnapshot.data["name"],
        documentSnapshot.data["description"]
    );
  }
}