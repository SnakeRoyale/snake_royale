import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Game extends BaseGame {
  Size screenSize;
  double tileSize;

  Game() {
    initialize();
  }

  void initialize() {

  }

  void render(Canvas canvas) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFF333333);

    canvas.drawRect(background, backgroundPaint);

    Sprite sprite = Sprite('sprites/snakes/default/circle.png');

    sprite.render(canvas);

  }

  void resize(Size size) {
    super.resize(size);

    screenSize = size;

    // TODO: Define subgrid size
    tileSize = screenSize.width  / 10;
  }
}