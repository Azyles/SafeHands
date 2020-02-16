import 'dart:ffi';
import 'dart:ui';
import 'Firebase/login_signup_page.dart';
import 'package:Nueva/Profile.dart';
import 'package:Nueva/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

import 'NavigationPage.dart';
import 'settingup/Oldornot.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseUser user;
  String error;

  void setUser(FirebaseUser user) {
    setState(() {
      this.user = user;
      this.error = null;
    });
  }

  void setError(e) {
    setState(() {
      this.user = null;
      this.error = e.toString();
    });
  }

  final databaseReference = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  _inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  void getData() async {
    databaseReference
        .collection("UserData")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((documentId) => print(getUID()['First Name']));
    });
  }

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    final documentId = getUID();
    return Firestore.instance
        .collection('UserName')
        .document('$documentId')
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetector()),
              );
            },
            child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new Image.network(
                  'https://wallpaperaccess.com/full/1273762.jpg',
                  fit: BoxFit.cover,
                )),
          ),
          Center(child: checkforaccount(context)),
        ],
      ),
    );
  }

  Widget checkforaccount(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(child: CircularProgressIndicator());
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Padding(
                padding: EdgeInsets.fromLTRB(6.0, 40.0, 6.0, 0.0),
                child: SizedBox(
                  height: 45.0,
                  child: new RaisedButton(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Colors.indigo[100],
                    child: new Text('Get Started',
                        style: new TextStyle(
                            fontSize: 20.0, color: Colors.grey[100])),
                    onPressed: () async {
                      final snapShot = await Firestore.instance
                          .collection('UserData')
                          .document(user.uid)
                          .get();

                      if (snapShot == null || !snapShot.exists) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetector()),
                        );
                        // Document with id == docId doesn't exist.
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabPage()),
                        );
                      }
                    },
                  ),
                ));
          }
        });
  }
}

/*



Center(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingUpPage()),
                                  );
                                },
                                child: Container(
                                    color: Colors.black,
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    child: Center(
                                      child: Text(
                                        'Get Stared',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )))),




                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );



         GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingUpPage()),
        );
      };
      
      child: Stack(
        children: <Widget>[
          new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new Image.network(
                  'https://wallpaperaccess.com/full/1273762.jpg')),
          new Center(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: GradientText("Nueva",
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.redAccent[400],
                                ],
                              ),
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w200),
                              textAlign: TextAlign.center),
                        ),
                        Text('pianifica e unisciti',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                            textAlign: TextAlign.center),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
*/
