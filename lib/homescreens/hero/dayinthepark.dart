import 'package:flutter/material.dart';

class dayinthepark extends StatefulWidget {
  @override
  _dayintheparkState createState() => _dayintheparkState();
}

class _dayintheparkState extends State<dayinthepark> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Hero(
                tag: "Dayinthepark",
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://streamline.imgix.net/ea237dbe-f1aa-4cf6-b1af-79aa46a762dc/8ece4c19-461a-4187-a883-52420ec6931d/Screen%20Shot%202019-09-18%20at%2010.12.21%20AM.png?ixlib=rb-1.1.0&w=2000&h=2000&fit=max&or=0&s=593221de6976e96d2db2cbddb0aa6be4',
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
                          'Day in the park',
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
