import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final width;
  final height;
  final color;

  ColorBox({this.width, this.height, this.color});

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      color: color,
    );
  }
}
