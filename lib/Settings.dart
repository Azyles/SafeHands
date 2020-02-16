import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Firebase/login_signup_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = new GlobalKey<FormState>();
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  final databaseReference = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  String _firstname;
  String _lastname;

  void editname() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .updateData({
      'First Name': '$_firstname',
      'Last Name': '$_lastname',
    });
  }


  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
              height: 205,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 205,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: <Widget>[DecoratedTextField(),],
                      ),
                    )
                  ]));
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              children: <Widget>[
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 260,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Text(
                              'Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                            child: new GestureDetector(
                          onTap: () {
                            _settingModalBottomSheet(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text(
                                  'Edit Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                        SizedBox(height: 10),
                        Center(
                            child: new GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text(
                                  'Edit Phone Number',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                        SizedBox(height: 10),
                        Center(
                            child: new GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text(
                                  'Edit Bio',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(15, 15, 15, 1),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 130,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                            child: new GestureDetector(
                          onTap: () {
                           FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginSignupPage()),
                      );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                      color: Colors.redAccent[400],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(15, 15, 15, 1),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class DecoratedTextField extends StatefulWidget {
  @override
  _DecoratedTextFieldState createState() => _DecoratedTextFieldState();
}

class _DecoratedTextFieldState extends State<DecoratedTextField> {
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  bool checkingFlight = false;

  bool success = false;

  final _formKey = new GlobalKey<FormState>();

  String _firstname;

  String _lastname;

  @override
  Widget build(BuildContext context) {
    final databaseReference = Firestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    getUID() async {
      final FirebaseUser user = await auth.currentUser();
      final uid = user.uid;
      return uid;
    }

    String _firstname;
    String _lastname;

      void editname() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .updateData({
      'First Name': '$_firstname',
      'Last Name': '$_lastname',
    });
  }

  return Form(
    key: _formKey,
    child: Column(
        children: <Widget>[
          Container(
            height: 50,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.grey[100]),
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                labelStyle: TextStyle(color: Colors.grey[700]),
                hintText: '  First Name',
              ),
              validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
              onSaved: (value) => _firstname = value.trim(),
            ),
          ),
          SizedBox(height: 0),
          Container(
            height: 50,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.grey[100]),
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                labelStyle: TextStyle(color: Colors.grey[700]),
                hintText: '  Last Name',
              ),
              validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
              onSaved: (value) => _lastname = value.trim(),
            ),
          ),
           !checkingFlight
          ? MaterialButton(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.grey[800],
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final form = _formKey.currentState;
                  // If the form is valid, display a Snackbar.
                  form.save();
                  editname();

                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    success = true;
                  });
                  await Future.delayed(Duration(milliseconds: 500));
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          : !success
              ? CircularProgressIndicator()
              : Icon(
                  Icons.check,
                  color: Colors.green,
                )
        ],
      ),
  );
  }
}
