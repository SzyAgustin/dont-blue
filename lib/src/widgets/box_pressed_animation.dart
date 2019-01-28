import 'package:flutter/material.dart';
import 'color_box.dart';

class BoxPressedAnimation extends StatefulWidget {
  @override
  _BoxPressedAnimationState createState() => _BoxPressedAnimationState();
}

class _BoxPressedAnimationState extends State<BoxPressedAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> _boxAnimation;
  AnimationController _boxController;

  @override
  void initState() {
    super.initState();

    _boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _boxAnimation = Tween(begin: 200.0, end: 300.0).animate(CurvedAnimation(
      parent: _boxController,
      curve: Curves.elasticInOut,
    ));

    _boxController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _boxController.dispose();
    super.dispose();
  }

  onTap() {
    if (_boxController.status == AnimationStatus.dismissed) {
      _boxController.forward();
    } else if (_boxController.status == AnimationStatus.completed) {
      _boxController.reverse();
      
    }

    // _boxController.forward();
    // _boxController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColorBox(
        //margin: EdgeInsets.only(top: _boxAnimation.value),
        height: _boxAnimation.value,
        width: _boxAnimation.value,
      ),
    );
  }
}
