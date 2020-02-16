import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_text/gradient_text.dart';
import 'Firebase/login_signup_page.dart';
import 'Profile.dart';
import 'package:encrypt/encrypt.dart';

class SettingUpPage extends StatefulWidget {
  @override
  _SettingUpPageState createState() => _SettingUpPageState();
}

class _SettingUpPageState extends State<SettingUpPage> {
  final _formKey = new GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String _firstname;

  String _lastname;

  bool enfofhao = false;

  var loginSignupPageInstance = LoginSignupPageState();

  void createRecord() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .updateData({
      'First Name': '$_firstname',
      'Last Name': '$_lastname',
    });
  }

  void recorduserdata() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .setData({
      'Name': 'True',
    });

    DocumentReference ref = await databaseReference.collection("UserData").add({
      '': 'Truer',
    });
    print(ref.documentID);
  }

  void getData() async {
    final documentId = await getUID();
    databaseReference
        .collection("UserData")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      databaseReference
          .collection('AccountData')
          .document('')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference.collection('books').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      SizedBox(height: 30),
      Row(
        children: <Widget>[
          SizedBox(width: 20),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image:
                      AssetImage('assets/Charming-Dove-Logo-Illustartion.jpg'),
                  fit: BoxFit.fitHeight),
            ),
          ),
        ],
      ),
      SizedBox(height: 30),
      Row(
        children: <Widget>[
          SizedBox(width: 20),
          Text('Almost\nThere',
              style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.left),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          SizedBox(width: 20),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 100,
            child: Text(
                'Before we can start you will need to fill in your details and accept our terms',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1),
                textAlign: TextAlign.left),
          )
        ],
      ),
      SizedBox(
        height: 70,
      ),
      Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[700]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                        hintText: '  First Name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Name can\'t be empty' : null,
                      onSaved: (value) => _firstname = value.trim(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[700]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                        hintText: '  Last Name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Name can\'t be empty' : null,
                      onSaved: (value) => _lastname = value.trim(),
                    ),
                  ),
                ),
              ),
            ],
          )),
      SizedBox(
        height: 50,
      ),
      GestureDetector(
        onTap: () {
          if (_formKey.currentState.validate()) {
            final form = _formKey.currentState;
            // If the form is valid, display a Snackbar.
            form.save();
            createRecord();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        child: Center(
            child: Center(
          child: Container(
              color: Colors.black,
              height: 45,
              width: MediaQuery.of(context).size.width - 40,
              child: Center(
                child: Text(
                  'Get Stared',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              )),
        )),
      ),
      SizedBox(
        height: 10,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
        child: Center(
            child: Center(
          child: Container(
              color: Colors.black,
              height: 45,
              width: MediaQuery.of(context).size.width - 40,
              child: Center(
                child: Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              )),
        )),
      ),
    ]));
  }
}

/*

class SettingUpPage extends StatefulWidget {
  @override
  _SettingUpPageState createState() => _SettingUpPageState();
}

class _SettingUpPageState extends State<SettingUpPage> {
  final _formKey = new GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String _firstname;

  String _lastname;

  var loginSignupPageInstance = LoginSignupPageState();

  void createRecord() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .setData({
      'First Name': '$_firstname',
      'Last Name': '$_lastname',
    });
  }

  void recorduserdata() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .setData({
      'Name': 'True',
    });

    DocumentReference ref = await databaseReference.collection("UserData").add({
      '': 'Truer',
    });
    print(ref.documentID);
  }

  void getData() async {
    final documentId = await getUID();
    databaseReference
        .collection("UserData")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      databaseReference
          .collection('AccountData')
          .document('')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference.collection('books').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Nueva\nAccount',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: new TextFormField(
                        style: TextStyle(color: Colors.grey[700]),
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[700]),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          hintText: 'First Name',
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Name can\'t be empty' : null,
                        onSaved: (value) => _firstname = value.trim(),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: new TextFormField(
                        style: TextStyle(color: Colors.grey[700]),
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[700]),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          hintText: 'Last Name',
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Name can\'t be empty' : null,
                        onSaved: (value) => _lastname = value.trim(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final form = _formKey.currentState;
                      // If the form is valid, display a Snackbar.
                      form.save();
                      createRecord();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    }
                  },
                  color: Colors.black,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 110),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
            SizedBox(height: 10),
            Center(
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  color: Colors.black,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 110),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginSignupPage()),
                  );
                },
                child: Text('Log Out'),
              ),
            ),
          ],
        ));
  }
}

/*

Center(
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginSignupPage()));
                  },
                  color: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            )

            
RaisedButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginSignupPage()),
  );
*/

*/
