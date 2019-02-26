import 'package:flutter/material.dart';
import 'dart:math';
import 'box_move_vibrate.dart';
import '../blocs/bloc.dart';

import 'package:vibration/vibration.dart';

class BoxRotate extends StatefulWidget {
  @override
  _BoxRotateState createState() => _BoxRotateState();
}

class _BoxRotateState extends State<BoxRotate>
    with SingleTickerProviderStateMixin {
  AnimationController _rotateController;
  Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _rotateAnimation = Tween(begin: 0.0, end: pi / 2).animate(CurvedAnimation(
      parent: _rotateController,
      curve: Curves.decelerate,
    ));

    _rotateAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateController.reset();
      } 
    });

    _rotateController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  onTap() {
    setState(() {});
    _rotateController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Transform.rotate(
          angle: _rotateAnimation.value,
          child: BoxMoveVibrate(),
        ),
      ),
    );
  }
}
