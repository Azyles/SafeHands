import 'dart:async';
import 'dart:ui';
import 'package:Nueva/NavigationPage.dart';
import 'package:Nueva/Settings.dart';
import 'package:Nueva/homescreens/AppHomePage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homescreens/Search.dart';
import 'homescreens/hero/messages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Material(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          )
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          new ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => new Icon(
                Icons.error,
                color: Colors.redAccent,
              ),
              placeholder: (context, url) => Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(),
                ),
              ),
              imageUrl:
                  'https://66.media.tumblr.com/95d3a5732b5bd9068d1ccb130cbcf956/tumblr_pnyes8R8rM1sxqinzo1_1280.jpg',
              fit: BoxFit.cover,
            ),
          ),
/*
              child: Image.network(
                'https://66.media.tumblr.com/95d3a5732b5bd9068d1ccb130cbcf956/tumblr_pnyes8R8rM1sxqinzo1_1280.jpg',
                fit: BoxFit.cover,
              )*/
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  name(context),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 300,
                    child: bio(context),
                  )
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      decoration: new BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.1)),
                      child: new Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: points(context)),
                              Center(
                                  child: Text(
                                'Points',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: helped(context)),
                              Center(
                                  child: Text(
                                'Helped',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: rating(context)),
                              Center(
                                  child: Text(
                                'Rating',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ))
                            ],
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          )
        ],
      ),
    ));
  }

  Widget name(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(
              documentFields["First Name"] +
                  " \n" +
                  documentFields["Last Name"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 35),
            );
          }
        });
  }
  Widget bio(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(
              documentFields["Bio"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            );
          }
        });
  }
  Widget points(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(
              documentFields["Points"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            );
          }
        });
  }
  Widget helped(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(
              documentFields["Helped"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            );
          }
        });
  }
  Widget rating(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(
              documentFields["Rating"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            );
          }
        });
  }
}
/*

Widget thismightwork(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document('cH54QySjemOyPbRMlYanvliiWDi1')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(
              documentFields["First Name"] + " " + documentFields["Last Name"],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            );
          }
        });
  }



  Widget building(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('UserData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            QuerySnapshot dataSnapshot = snapshot.data.snapshot;
            return new Text(dataSnapshot.documents.toString());
          }
        });
  }

  Widget buildings(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('UserData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            return new Text(snapshot.data.toString());
          }
        });
  }

  Widget gettingdata(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('UserData')
            .document('TjMJDFd940UtLORgdYND771GYwG2')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Text(userDocument["First Name"].toString());
        });
  }

  Widget thiswillword(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('UserData')
            .document(getUID())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
            return Text(documentFields["First Name"] +
                " " +
                documentFields["Last Name"]);
          }
        });
  }
}


--------------------------------------------------------
Text(snapshot.data.toString());

Center(
                    child: StreamBuilder(
                  stream: Firestore.instance.collection('UserData').where('First Name').snapshots(),
                  builder: (context, snapshot)  {
                    final documentId = getUID();
                    if (!snapshot.hasData) return Text('Loading...');
                    return Column(
                      children: <Widget>[
                        Text(snapshot.data.document['documentId']['First Name'])
                      ],
                    );
                  },
                )),

--------------------------------------------------------

_buildList(context, snapshot.data.documents[index]);

--------------------------------------------------------

*/
