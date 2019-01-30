import 'package:flutter/material.dart';
import '../widgets/box_pressed_animation.dart';
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
        backgroundColor: Colors.cyan,
        title: Text('Do not touch the Blue!'),
      ),
      body: Center(
        child: BoxPressedAnimation(),
      ),
    );
  }
}
