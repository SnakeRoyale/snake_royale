
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:snake_royale/components/snake.dart';

class Game extends BaseGame {
  Size screenSize;
  double tileSize;
  Snake snake = new Snake(2);

  Game() {
    initialize();
  }

  void initialize() {

  }

  void update(double t){
    this.snake.update(t);
  }
  void render(Canvas canvas) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFF555555);

    canvas.drawRect(background, backgroundPaint);



    this.snake.render(canvas);
    this.snake.move(new Offset(1,0));

  }

  void resize(Size size) {
    super.resize(size);

    screenSize = size;

    // TODO: Define subgrid size
    tileSize = screenSize.width  / 10;
  }
}
