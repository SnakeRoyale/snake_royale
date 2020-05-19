import 'package:flutter/material.dart';

class BezierClipper extends CustomClipper<Path>{
  final double animationValue;
  BezierClipper({this.animationValue});

  @override
  Path getClip(Size size)  {
    Path path = new Path();
    path.lineTo(0, animationValue *0.76 ); //vertical line
    path.cubicTo(size.width/3 , animationValue * 0.9,  2*size.width/3, animationValue*0.6, size.width, animationValue*0.75); //cubic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}