import 'dart:ffi';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:snake_royale/interfaces/movable.dart';

class SnakeBody implements Movable {
  String name;
  String color;
  Uint32 mass;
  SpriteComponent sprite;

  SnakeBody(Offset position, {bool isHead = false}) {
    _draw(position, isHead);
  }

  void update(double t) {}

  void _drawBody(Canvas canvas, Offset offset) {}

  void render(Canvas canvas) {
    this.sprite.render(canvas);
  }

  void move(Offset offset) {
    this.sprite.setByRect(this.sprite.toRect().shift(Offset(1,1)));
  }

  void _draw(Offset position, bool isHead) {
    var circle = Flame.images.loadedFiles[isHead
        ? 'sprites/snakes/default/head.png'
        : 'sprites/snakes/default/circle.png'];
    var sprite = Sprite.fromImage(circle);
    double size = circle.height.toDouble();
    this.sprite =
        SpriteComponent.fromSprite(size, size, sprite); // width, height, sprite
    this.sprite.x = position.dx; // 0 by default
    this.sprite.y = position.dy; // 0 by default
    this.sprite.angle = 0; // 0 by default
  }
}
