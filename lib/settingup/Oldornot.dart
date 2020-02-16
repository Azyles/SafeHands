import 'package:Nueva/settingup/elderinfo.dart';
import 'package:Nueva/settingup/youth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetector extends StatefulWidget {
  @override
  _UserDetectorState createState() => _UserDetectorState();
}

class _UserDetectorState extends State<UserDetector> {
  @override
  bool elderly = false;

  bool youth = false;

  final databaseReference = Firestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  void createRecord() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .setData({
      'Elder': '$elderly',
      'Youth': '$youth',
      'RoleSet': 'True',
    });
  }

  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            SizedBox(height: 60),
            Center(
                child: Text(
              'Choose\n Your Service',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 36,
              ),
              textAlign: TextAlign.center,
            )),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                setState(() {
                  elderly = true;
                  youth = false;
                });
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/78e826ca1b9351214dfdd5e47f7e2024.gif'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Elderly',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Pick this if you require\n app travel services',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.grey[300]),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: elderly
                          ? Colors.blue[50].withOpacity(0.5)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  elderly = false;
                  youth = true;
                });
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/78e826ca1b9351214dfdd5e47f7e2024.gif'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Care Taker',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Pick this if you wish\n to assist elderly',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.grey[300]),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: elderly
                          ? Colors.white
                          : Colors.blue[50].withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  if (elderly == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Youth()),
                    );
                    print('youth');
                    createRecord();
                  }
                  if (elderly == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ElderInfo()),
                    );
                    print('Elder');
                    createRecord();
                  }
                  ;
                },
                child: Center(
                    child: Container(
                  height: 60,
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15)),
                )))
          ],
        ),
      ),
    );
  }
}
