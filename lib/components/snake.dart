import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';


class SnakeComponent extends BodyComponent{
  SnakeComponent(Box2DComponent box) : super(box);

  num snakeMass = 10;

  @override
  void update(double t) {
    // TODO: implement update
    super.update(t);
  }

  @override
  void renderChain(Canvas canvas, List<Offset> points) {
    // TODO: implement renderChain
    super.renderChain(canvas, points);
  }


}