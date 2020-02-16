import 'dart:ui';

import 'package:Nueva/homescreens/searchalso.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
                  'https://i.pinimg.com/originals/52/53/3a/52533ac0db52da0d90fecf7c4c3dca3f.jpg',  fit: BoxFit.cover,
            ),),
            new Center(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.black.withOpacity(0.2)),
                    child: new Center(
                        child: new Center(
                            child: Container(
                      height: 300,
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Look for match',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 40),
                          RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            color: Colors.indigo[100],
                            child: new Text('Find Match',
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.grey[100])),
                            onPressed: () async {
                              showAlertDialog(context);
                            },
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(30)),
                    ))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LookingForMatch()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Look For Match?"),
      content: Text("Would you like to continue looking for a match?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['Firstname']),
    );
  }

  Widget _showCircularProgress(BuildContext context) {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo[300]),
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}

/*
StreamBuilder(
                        stream:
                            Firestore.instance.collection('Elders').snapshots(),
                        //print an integer every 2secs, 10 times
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Loading..");
                          }
                          return ListView.builder(
                            itemExtent: 80.0,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return _buildList(
                                  context, snapshot.data.documents[index]);
                            },
                          );
                        },
                      ),
*/
