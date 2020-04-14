import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessData {
  final String uid;
  final String address;
  final LatLng coordinates;
  final String name;

  BusinessData(this.uid, this.address, this.coordinates, this.name);
}