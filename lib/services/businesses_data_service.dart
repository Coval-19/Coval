import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coval/models/business_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessesDataService {
  final CollectionReference _businessesCollection =
      Firestore.instance.collection('businesses');

  BusinessData _businessDataFromDocument(DocumentSnapshot documentSnapshot) {
    GeoPoint point = documentSnapshot.data["addressCoordinates"];
    return BusinessData(
      documentSnapshot.documentID,
      documentSnapshot.data["address"],
      LatLng(point.latitude, point.longitude),
      documentSnapshot.data["name"]
    );
  }

  Future<List<BusinessData>> getBusinesses() async {
    return _businessesCollection.getDocuments().then((snapshot) {
      return snapshot.documents.map(_businessDataFromDocument).toList();
    });
  }
}
