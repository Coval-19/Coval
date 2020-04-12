import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coval/models/user_data.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDatabaseService {
  final String uid;
  final CollectionReference _userCollection =
      Firestore.instance.collection('users');
  StorageReference _storageReference;

  UserDatabaseService({this.uid}) {
    this._storageReference = FirebaseStorage.instance.ref().child('users/$uid');
  }

  Future<void> updateUserData(
      String name, String socialNumber, File image) async {
    StorageUploadTask uploadTask = _storageReference.putFile(image);
    await uploadTask.onComplete;
    return await _userCollection.document(uid).setData({
      'name': name,
      'socialNumber': socialNumber,
    });
  }

  FutureOr<UserData> _userDataFromSnapshot(DocumentSnapshot document) async {
    print(document.data);
    return document.data != null
        ? UserData(
            name: document.data['name'],
            socialNumber: document.data['socialNumber'],
            imageUrl: await _storageReference.getDownloadURL())
        : null;
  }

  Stream<UserData> get userData {
    return Stream.fromFuture((_userCollection
        .document(uid)
        .snapshots()
        .asyncMap(_userDataFromSnapshot)
        .firstWhere((value) {
      return value != null;
    })));
  }
}
