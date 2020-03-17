import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

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
    Paint backgroundPaint = Paint()..color = Color(0xFF555555);

    canvas.drawRect(background, backgroundPaint);

    //  sprite = new // ('sprites/snakes/default/circle.png');
    // SpriteComponent player = SpriteComponent.fromSprite(100, 100, sprite);

    // player.x = screenSize.width / 2 - player.width / 2;
    // player.y = screenSize.height / 2 - player.height / 2;

    // player.render(canvas);

    Flame.images.load('sprites/snakes/default/circle.png').then((Image image) {
      Paint paint = Paint()..color = Color(0xFFFFFFFF);
      Rect rect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());

      canvas.drawImageRect(image, rect, rect, paint);
    });
  }

  void resize(Size size) {
    super.resize(size);

    screenSize = size;

    // TODO: Define subgrid size
    tileSize = screenSize.width  / 10;
  }
}
