import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BusinessVisit {
  final String uid;
  final String timeStamp;
  final String name;
  final String address;

  BusinessVisit(this.timeStamp, this.name, this.address, this.uid);

  factory BusinessVisit.fromFireStore(DocumentSnapshot documentSnapshot) {
    Timestamp timestamp = documentSnapshot['timestamp'];
    return BusinessVisit(
      DateFormat.yMMMd()
          .add_jm()
          .format(DateTime.parse(timestamp.toDate().toString()))
          .toString(),
      documentSnapshot['businessName'],
      documentSnapshot['businessAddress'],
      documentSnapshot['businessId']
    );
  }
}
