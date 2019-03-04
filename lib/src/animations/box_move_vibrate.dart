import 'dart:async';

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
    // Colors.pinkAccent,
    // Colors.orangeAccent[400]
  ];
  int timeToTap = 1000;
  bool lost = false;
  static Timer _timer;
  bool firstTime = true;
  int points = 0;

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
    if (color == Colors.indigo[700]) {
      setState(() {
        Vibration.vibrate(duration: 500);
        lost = true;
        if (_timer.isActive) {
          _timer.cancel();
        }
      });
    } else {
      _boxController.forward();
      newBox();
    }
  }

  void start(){
    setState(() {
      points = 0;
    });
    _boxController.forward();
    newBox();
  }

  //this method should be modified.
  void newBox() {
    setState(() {
      if (firstTime) {
        firstTime = false;
        _timer = startTimeout();
        points++;
      } else {
        if (_timer.isActive) {
          _timer.cancel();
        }
        lost = false;
        // if (points/7 )
        color = colors[Random().nextInt(colors.length)];
        timeToTap = (250 + Random().nextInt(350));
        _timer = startTimeout();
        points++;
      }
    });
    Vibration.vibrate(duration: 150);
  }

  startTimeout() {
    var duration = Duration(milliseconds: timeToTap + 250);
    return Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    if (color == Colors.indigo[700]) {
      _boxController.forward();
      newBox();
    } else {
      setState(() {
        lost = true;
      });
      Vibration.vibrate(duration: 500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: play(),
    );
  }

  Widget play() {
    if (firstTime) {
      return startView("Are you ready?");
    }
    if (lost) {
      return startView("Lost at $points boxes");
    }
    return box();
  }

  Widget startView(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$message',
            style: TextStyle(
              fontSize: 40.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey,
            )),
        MaterialButton(
          onPressed: start,
          color: Colors.indigo[700],
          child: Text(
            'Start game',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget box() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$points',
            style: TextStyle(
              fontSize: 40.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey,
            )),
        Container(
          height: _boxAnimation.value,
          width: _boxAnimation.value,
          child: AnimatedContainer(
            child: ProgressBar(
              time: timeToTap,
            ),
            duration: Duration(
              milliseconds: 250,
            ),
            color: color,
            curve: Curves.easeOut,
          ),
        ),
      ],
    );
  }
}
