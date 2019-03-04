import 'package:flutter/material.dart';
import '../animations/box_move_vibrate.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Animation<double> boxAnimation;

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('Do not touch the Blue!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BoxMoveVibrate(),
          ],
        ),
      ),
    );
  }
}
