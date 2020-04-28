import 'dart:ffi';
import 'dart:ui';

import 'package:snake_royale/components/snake_body.dart';
import 'package:snake_royale/interfaces/movable.dart';

class Snake implements Movable {
  String name;
  String color;
  Uint32 mass;
  double lastMoveRadAngle = 0;

  // List<SpriteComponent> sprites = new List();
  List<SnakeBody> bodyParts = new List();

  Snake(int length, int x, int y) {
    _createHead(new Offset(150, 250));
    _createBody(length);
  }

  void update(double t) {
    for(var part in this.bodyParts){
      part.sprite.angle = this.lastMoveRadAngle -90;
    }
  }

  void _createHead(Offset offset) {
    var head = new SnakeBody(offset, isHead: true);
    this.bodyParts.add(head);
  }

  void _drawBody(Canvas canvas, Offset offset) {}

  void render(Canvas canvas) {
    for (var bodyPart in this.bodyParts) {
      bodyPart.render(canvas);
    }
  }

  Future<void> move(Offset offset) async {
    for (var bodyPart in this.bodyParts) {
      bodyPart.move(offset);
    }
  }

  void _createBody(int length) {
    for (int i = 0; i < length; i++) {
      var bodyPart =
          new SnakeBody(new Offset(150, (250 + (i + 1) * 30).toDouble()));
      this.bodyParts.add(bodyPart);
    }
  }
}
