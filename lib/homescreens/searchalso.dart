import 'package:Nueva/Firebase/login_signup_page.dart';
import 'package:Nueva/NavigationPage.dart';
import 'package:Nueva/settingup/elderinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LookingForMatch extends StatefulWidget {
  @override
  _LookingForMatchState createState() => _LookingForMatchState();
}

class _LookingForMatchState extends State<LookingForMatch> {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
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

    String _errorMessage = '';

    bool _isLoginForm;

    bool _isLoading;

    String _firstname;

    String _lastname;

    String _bio;

    String _phonenumber;

    bool background_check;

    bool enfofhao = false;

    var loginSignupPageInstance = LoginSignupPageState();

    void createRecord() async {
      final documentId = await getUID();
      await databaseReference
          .collection("UserData")
          .document("$documentId")
          .updateData({
        'Partnar Doc UID': '$documentId',
      });
    }

    bool saved = false;
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        document['First Name'] + ' ' + document['Last Name'],
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 160),
                      IconButton(
                          icon: Icon(
                            Icons.add,
                            color: saved ? Colors.redAccent[400] : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              saved = true;
                            });
                          })
                    ],
                  )
                ],
              ),
            )));
  }
  /*
  ListTile(
      title: Text(document['First Name'] + ' ' + document['Last Name']),
    );
    */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 20.0, // has the effect of softening the shadow
                    spreadRadius: 3.0, // has the effect of extending the shadow
                    offset: Offset(
                      0.0, // horizontal, move right 10
                      10.0, // vertical, move down 10
                    ),
                  )
                ],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            height: 360,
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              SizedBox(height: 50),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('SafeHands,\nMatches',
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
                        'We have found some elders below. Click add to send them a request and you will get a message',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[100]),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 30),
                        Text(
                          'hello',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )),
              )
            ]),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            5.0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                height: 50,
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Shabd Veykula',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width:100),
                    Icon(Icons.lightbulb_outline)
                  ],
                )),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            5.0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                height: 50,
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Pranav Krishna',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width:100),
                    Icon(Icons.lightbulb_outline)
                  ],
                )),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            5.0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                height: 50,
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Raviteja Pillalamarri',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width:100),
                    Icon(Icons.lightbulb_outline)
                  ],
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TabPage()),
          );
        },
      ),
    );
  }
}
