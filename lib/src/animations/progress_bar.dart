import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController _progController;
  Animation<double> _progAnimation;
  int finish = 1000;

  @override
  void initState() {
    super.initState();
    _progController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (1000 + Random().nextInt(38500))),
    );

    _progAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _progController,
      curve: Curves.linear,
    ));

    _progController.addListener(() {
      setState(() {});
    });

    // _progAnimation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _progController.reset();
    //   }

    //   _progController.forward();
    // });
    _progController.forward();
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    setState(() {
      finish = (1000 + Random().nextInt(38500));
      _progController.duration = Duration(milliseconds: finish);
    });
    // _progController.
    _progController.reset();
    _progController.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _progController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 15.0,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey[350]),
      value: _progAnimation.value,
      semanticsLabel: finish.toString(),
    );
  }
}
