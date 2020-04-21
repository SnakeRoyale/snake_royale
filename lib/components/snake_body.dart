import 'dart:ffi';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
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

  void update(double t) {
    this.sprite.update(t);
  }

  void _drawBody(Canvas canvas, Offset offset) {}

  void render(Canvas canvas) {
    canvas.save();
    this.sprite.render(canvas);
    canvas.restore();
  }

  void move(Offset offset) {
    this.sprite.x += offset.dx;
    this.sprite.y += offset.dy;
  }

  void _draw(Offset position, bool isHead) {
    var circle = Flame.images.loadedFiles[isHead
        ? 'sprites/snakes/default/head.png'
        : 'sprites/snakes/default/circle.png'];
    var sprite = Sprite.fromImage(circle);
    double size = circle.height.toDouble();
    this.sprite =
        SpriteComponent.fromSprite(size, size, sprite); // width, height, sprite

    // this.sprite.y += 30;
    // this.sprite.x += position.dx;
    this.sprite.y += position.dy;


    this.sprite.angle = 0; // 0 by default
  }
}
