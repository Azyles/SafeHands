import 'dart:ui';

import 'package:Nueva/settingup/elderinfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
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
                        document['Invite Name'] +
                            ' ' +
                            document['Invite Last Name'],
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 160),
                      IconButton(
                          icon: Icon(
                            Icons.check,
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
              Container(
                  height: 200,
                  width: 200,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => new Icon(
                      Icons.error,
                      color: Colors.redAccent,
                    ),
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    imageUrl:
                        'https://cdn4.iconfinder.com/data/icons/avatar-circle-1-1/72/56-512.png',
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  )),
              SizedBox(height: 30),
              Text('Frank Graham',
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 75,
                    width: 75,
                    child: Icon(
                      Icons.call,
                      size: 30,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 75,
                    child: Icon(
                      Icons.new_releases,
                      size: 50,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent[400],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 75,
                    child: Icon(
                      Icons.cancel,
                      size: 60,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 00.0, sigmaY: 00.0),
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
                            children: <Widget>[],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        backgroundColor: Colors.grey[500],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ElderInfo()),
          );
        },
      ),
    );
  }
}
