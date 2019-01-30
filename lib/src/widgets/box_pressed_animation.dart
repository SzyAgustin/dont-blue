import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';

class BoxPressedAnimation extends StatefulWidget {
  @override
  _BoxPressedAnimationState createState() => _BoxPressedAnimationState();
}

class _BoxPressedAnimationState extends State<BoxPressedAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> _boxAnimation;
  AnimationController _boxController;
  int counter = 0;
  Color color = Colors.blue;
  List<Color> colors = [Colors.indigo[700], Colors.greenAccent[700], Colors.redAccent[700]];

  @override
  void initState() {
    super.initState();

    _boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 25),
    );

    _boxAnimation = Tween(begin: 200.0, end: 205.0).animate(CurvedAnimation(
      parent: _boxController,
      curve: Curves.easeIn,
    ));

    _boxController.addListener(() {
      setState(() {});
    });

    _boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _boxController.forward();
        counter++;
      }
      if (counter == 3) {
        counter = 0;
        _boxController.stop();
      }
    });
  }

  @override
  void dispose() {
    _boxController.dispose();
    super.dispose();
  }

  onTap() {
    executeAnimation();
    setState(() {});
  }

  executeAnimation() {
    _boxController.forward();
    Vibration.vibrate(duration: 150);
    nextColor();
  } 

  nextColor(){
    color = colors[Random().nextInt(3)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _boxAnimation.value,
        width: _boxAnimation.value,
        color: color,
      ),
    );
  }
}
