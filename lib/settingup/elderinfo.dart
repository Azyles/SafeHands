import 'dart:ui';

import 'package:Nueva/Firebase/login_signup_page.dart';
import 'package:Nueva/Profile.dart';
import 'package:Nueva/Welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:encrypt/encrypt.dart';

import '../NavigationPage.dart';

class ElderInfo extends StatefulWidget {
  @override
  _ElderInfoState createState() => _ElderInfoState();
}

class _ElderInfoState extends State<ElderInfo> {
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

  String _bio;

  String _medications;

  String _phonenumber;

  bool enfofhao = false;

  var loginSignupPageInstance = LoginSignupPageState();

  void createRecord() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .updateData({
          'DocumentId': '$documentId',
      'First Name': '$_firstname',
      'Last Name': '$_lastname',
      'Bio': '$_bio',
      'Medications': '$_medications',
      'PhoneNumber': '$_phonenumber',
      'NameSet': 'True',
      'Points': '0',
      'Helped': '0',
      'Rating': '0',
    });
  }

  void eRecord() async {
    final documentId = await getUID();
    await databaseReference
        .collection("Elders")
        .document("$documentId")
        .setData({
          'DocumentId': '$documentId',
      'First Name': '$_firstname',
      'Last Name': '$_lastname',
    });
  }

    void arecord() async {
    final documentId = await getUID();
    await databaseReference
        .collection("Messages")
        .document("$documentId")
        .setData({
          'Message':'welcome to messages'
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
      SizedBox(height: 50),
      Row(
        children: <Widget>[
          SizedBox(width: 20),
          Text('Almost,\nThere',
              style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        children: <Widget>[
          SizedBox(width: 20),
          Container(
            width: MediaQuery.of(context).size.width - 120,
            child: Text(
                'We are almost complete just fill in the information below',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left),
          ),
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
                      style: TextStyle(color: Colors.grey[400]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300]),
                        labelStyle: TextStyle(color: Colors.grey[300]),
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
                      style: TextStyle(color: Colors.grey[400]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300]),
                        labelStyle: TextStyle(color: Colors.grey[300]),
                        hintText: '  Last Name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Name can\'t be empty' : null,
                      onSaved: (value) => _lastname = value.trim(),
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
                      style: TextStyle(color: Colors.grey[400]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300]),
                        labelStyle: TextStyle(color: Colors.grey[300]),
                        hintText: '  Bio',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Bio can\'t be empty' : null,
                      onSaved: (value) => _bio = value.trim(),
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
                      style: TextStyle(color: Colors.grey[400]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300]),
                        labelStyle: TextStyle(color: Colors.grey[300]),
                        hintText: '  Medications (if none then type \'none\')',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Medications can\'t be empty' : null,
                      onSaved: (value) => _medications = value.trim(),
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
                      style: TextStyle(color: Colors.grey[400]),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300]),
                        labelStyle: TextStyle(color: Colors.grey[300]),
                        hintText: '  PhoneNumber',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'PhoneNumber can\'t be empty' : null,
                      onSaved: (value) => _phonenumber = value.trim(),
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
            eRecord();
            arecord();
            createRecord();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
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
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
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

class ElderInfo extends StatefulWidget {
  @override
  _ElderInfoState createState() => _ElderInfoState();
}

class _ElderInfoState extends State<ElderInfo> {
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
