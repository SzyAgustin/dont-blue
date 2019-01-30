import 'package:flutter/material.dart';
import 'color_box.dart';
import 'package:vibration/vibration.dart';

class BoxPressedAnimation extends StatefulWidget {
  @override
  _BoxPressedAnimationState createState() => _BoxPressedAnimationState();
}

class _BoxPressedAnimationState extends State<BoxPressedAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> _boxAnimation;
  AnimationController _boxController;
  int counter = 0;
  bool green = false;

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
        if (counter == 3) {
          counter = 0;
          _boxController.stop();
        }
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

    green = !green;
    setState(() { 
    });
  }

  executeAnimation() {
    _boxController.forward();
    Vibration.vibrate(duration: 75);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: green
          ? ColorBox(
              //margin: EdgeInsets.only(top: _boxAnimation.value),
              height: _boxAnimation.value,
              width: _boxAnimation.value,
              color: Colors.lightGreenAccent[700],
            )
          : ColorBox(
              //margin: EdgeInsets.only(top: _boxAnimation.value),
              height: _boxAnimation.value,
              width: _boxAnimation.value,
              color: Colors.indigo[700],
            ),
    );
  }
}
