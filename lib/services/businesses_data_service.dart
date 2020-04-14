import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coval/models/business_data.dart';

class BusinessesDataService {
  final CollectionReference _businessesCollection =
      Firestore.instance.collection('businesses');

  Stream<List<BusinessData>> streamBusinesses() {
    return _businessesCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => BusinessData.fromFireStore(doc))
          .toList();
    });
  }
}
