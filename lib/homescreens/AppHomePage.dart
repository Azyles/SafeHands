import 'package:Nueva/homescreens/hero/dayinthebeach.dart';
import 'package:flutter/material.dart';
import 'package:snaplist/size_providers.dart';
import 'package:snaplist/snaplist.dart';
import 'hero/dayinthepark.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  SizedBox(width: 30),
                  Text(
                    'Explore',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(width: 30),
                  Text(
                    'Trending Activites',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                child: PageView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return dayinthepark();
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: "Dayinthepark",
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Text(
                                    'Day in the park',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://streamline.imgix.net/ea237dbe-f1aa-4cf6-b1af-79aa46a762dc/8ece4c19-461a-4187-a883-52420ec6931d/Screen%20Shot%202019-09-18%20at%2010.12.21%20AM.png?ixlib=rb-1.1.0&w=2000&h=2000&fit=max&or=0&s=593221de6976e96d2db2cbddb0aa6be4',
                                ),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return dayinthebeach();
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: "Dayinthepark",
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Text(
                                    'Day in the Beach',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&w=1000&q=80',
                                ),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ]),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                SizedBox(width: 30),
                Text(
                  'Trending Categories',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                SizedBox(width: 30),
                Text(
                  'get inspiration from one of\nthese trending categories',
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.3),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Astrology',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://freight.cargo.site/t/original/i/5e537d1a0cf5b9ba73f6d6b3956530b48688dd0b87d17713d5a0b58df2de06d5/thisispaper-architecture-open-architecture-mars-case-003.jpg'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Art',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/c9/a1/e8/c9a1e88b35e2c1259e9d840a7bcf7e42.jpg'),
                          fit: BoxFit.cover)),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Modern Art',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.officelovin.com/wp-content/uploads/2019/02/mow-supernova-coworking-m.jpg'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Forest',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://s3.wp.wsu.edu/uploads/sites/609/2019/07/forest-1188x792.jpg'),
                          fit: BoxFit.cover)),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Modern Art',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.minnesotamonthly.com/wp-content/uploads/sites/85/2018/05/Waterfall.jpg'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Shopping',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.dailyherald.com/storyimage/DA/20190911/BUSINESS/190919704/AR/0/AR-190919704.jpg&updated=201909111614&MaxW=900&maxH=900&noborder&Q=80'),
                          fit: BoxFit.cover)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
