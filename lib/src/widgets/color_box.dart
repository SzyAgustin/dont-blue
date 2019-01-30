import 'package:flutter/material.dart';

class ColorBox extends StatefulWidget {
  final width;
  final height;
  final color;

  ColorBox({this.width, this.height, this.color});

  @override
  ColorBoxState createState() {
    return new ColorBoxState();
  }
}

class ColorBoxState extends State<ColorBox> {
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.width,
      color: widget.color,
    );
  }
}
