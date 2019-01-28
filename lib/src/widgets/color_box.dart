import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final width;
  final height;

  ColorBox({this.width, this.height});

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      color: Colors.blue,
    );
  }
}
