import 'package:flutter/material.dart';

class dayinthebeach extends StatefulWidget {
  @override
  _dayinthebeachState createState() => _dayinthebeachState();
}

class _dayinthebeachState extends State<dayinthebeach> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Hero(
                tag: "dayinthebeach",
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&w=1000&q=80',
                    fit: BoxFit.cover,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 540,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Day in the Beach',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse in commodo ipsum, eget auctor sapien. Fusce purus velit, tempus sit amet nibh eu, posuere faucibus orci. Duis ac tortor egestas, tristique dui id, malesuada nisl. Suspendisse vel cursus metus, nec gravida quam. Nam nec pellentesque arcu. Vivamus auctor, dolor eu vulputate venenatis, lectus magna mollis elit, vel finibus magna mi eu velit. Phasellus efficitur, nunc nec accumsan accumsan, lectus massa bibendum sapien, vel ullamcorper erat eros sollicitudin augue. Nulla facilisi. Aenean blandit laoreet libero at tempor. Morbi gravida condimentum turpis vel mollis.',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.grey[900],
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
