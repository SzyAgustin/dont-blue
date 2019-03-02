import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'progress_bar.dart';
import 'dart:math';

class BoxMoveVibrate extends StatefulWidget {
  @override
  _BoxMoveVibrateState createState() => _BoxMoveVibrateState();
}

class _BoxMoveVibrateState extends State<BoxMoveVibrate>
    with SingleTickerProviderStateMixin {
  Animation<double> _boxAnimation;
  AnimationController _boxController;
  int counter = 0;
  Color color = Colors.greenAccent[700];
  List<Color> colors = [
    Colors.indigo[700],
    Colors.greenAccent[700],
    Colors.redAccent[700],
    Colors.yellowAccent[700],
    Colors.pinkAccent,
    Colors.orangeAccent[400]
  ];

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

  @override
  void didUpdateWidget(BoxMoveVibrate oldWidget) {
    setState(() => color = colors[Random().nextInt(colors.length)]);
    _boxController.reset();
    _boxController.forward();
    super.didUpdateWidget(oldWidget);
  }

  onTap() {
    if (color != Colors.indigo[700]) {
      setState(
        () => color = colors[Random().nextInt(colors.length)],
      );
      Vibration.vibrate(duration: 150);
      // _boxController.reset();
      _boxController.forward();
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _boxAnimation.value,
        width: _boxAnimation.value,
        child: AnimatedContainer(
          child: ProgressBar(),
          duration: Duration(
            milliseconds: 250,
          ),
          color: color,
          curve: Curves.easeOut,
        ),
      ),
    );
  }
}
