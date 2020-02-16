import 'package:Nueva/settingup/elderinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LookingForMatch extends StatefulWidget {
  @override
  _LookingForMatchState createState() => _LookingForMatchState();
}

class _LookingForMatchState extends State<LookingForMatch> {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
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
      body: ListView(
        children: <Widget>[
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
            height: 70,
          ),
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width - 20,
            child: StreamBuilder(
              stream: Firestore.instance.collection('Elders').snapshots(),
              //print an integer every 2secs, 10 times
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading..");
                }
                return ListView.builder(
                    itemExtent: 80.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return _buildList(
                          context, snapshot.data.documents[index]);
                    });
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        backgroundColor: Colors.grey[500],
        onPressed: () {
          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ElderInfo()),
                        );
        },
      ),
    );
  }
}
