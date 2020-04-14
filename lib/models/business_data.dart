import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessData {
  final String uid;
  final String address;
  final LatLng coordinates;
  final String name;

  BusinessData(this.uid, this.address, this.coordinates, this.name);

  factory BusinessData.fromFireStore(DocumentSnapshot documentSnapshot) {
    GeoPoint point = documentSnapshot.data["addressCoordinates"];
    return BusinessData(
        documentSnapshot.documentID,
        documentSnapshot.data["address"],
        LatLng(point.latitude, point.longitude),
        documentSnapshot.data["name"]
    );
  }
}