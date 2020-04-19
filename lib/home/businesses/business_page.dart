import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coval/models/business_data.dart';
import 'package:coval/models/user_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signature/signature.dart';

class BusinessPage extends StatefulWidget {
  final BusinessData businessData;
  final UserData userData;

  const BusinessPage({Key key, this.businessData, this.userData}) : super(key: key);

  @override
  _BusinessPageState createState() => _BusinessPageState(businessData, userData);
}

class _BusinessPageState extends State<BusinessPage> {
  final BusinessData businessData;
  final UserData userData;
  String _imageUrl;
  CollectionReference _businessRequestCollection;

  _BusinessPageState(this.businessData, this.userData) {
    _businessRequestCollection = Firestore.instance
        .collection('businesses')
        .document(businessData.uid)
        .collection('requests');
  }

  @override
  void initState() {
    getImageURL();
    super.initState();
  }

  void getImageURL() async {
    FirebaseStorage.instance
        .ref()
        .child('businesses/${businessData.uid}')
        .getDownloadURL()
        .then((value) {
      setState(() {
        _imageUrl = value;
      });
    });
  }

  void _sendVisitRequest() async {
    final SignatureController _controller =
    SignatureController(penStrokeWidth: 5, penColor: Colors.black);
    final hasUserAgreed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Health Declaration"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("I declare that i am feeling ok, and dont have any sympthoms"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Sign Here:"),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Signature(
                          controller: _controller,
                          height: 100,
                          backgroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Agree"),
              onPressed: () {
                if(_controller.isNotEmpty) {
                  Navigator.pop(context, true);
                }
              },
            ),
            MaterialButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context, false),
            )
          ],
        ));
    if(hasUserAgreed) {
      await _businessRequestCollection.add({'userId': userData.uid});
      Fluttertoast.showToast(
          msg: "Request Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: screenWidth,
            height: screenWidth / 2,
            child: _imageUrl != null && _imageUrl.trim() != ""
                ? Image.network(
                    _imageUrl,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              businessData.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38.0),
            ),
          ),
          Expanded(
            child: businessData.description != null &&
                    businessData.description.trim() != ""
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      var maxLines =
                          ((constraints.maxHeight / 18.0).floor() - 1);
                      return maxLines > 0
                          ? Text(
                              businessData.description,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black54),
                              maxLines: maxLines,
                            )
                          : Container();
                    }),
                  )
                : Container(),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color(4278501120),
          width: screenWidth,
          height: screenWidth / 10,
          child: Center(
            child: FlatButton(
              child: Text("Visit Place",
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: _sendVisitRequest,
            ),
          ),
        ),
      ),
    ));
  }
}
