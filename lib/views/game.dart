
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:snake_royale/components/controller.dart';
import 'package:snake_royale/components/snake.dart';

class Game extends BaseGame {
  Size screenSize;
  double tileSize;
  Snake snake;
  Controller controller;

  Game() {
    initialize();
  }

  void initialize() {
    this.tileSize = 1;
    controller = Controller(this);
    snake = new Snake(2);
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

  @override
  void update(double t) {
    controller.update(t);
    snake.update(t);
  }

  void onPanStart(DragStartDetails details) {
    controller.onPanStart(details);
  }

  void onPanUpdate(DragUpdateDetails details) {
    controller.onPanUpdate(details);
  }

  void onPanEnd(DragEndDetails details) {
    controller.onPanEnd(details);
  }
}
