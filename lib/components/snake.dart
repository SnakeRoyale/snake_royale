import 'dart:ffi';
import 'dart:ui';

import 'package:snake_royale/components/snake_body.dart';
import 'package:snake_royale/interfaces/movable.dart';

class Snake implements Movable {
  String name;
  String color;
  Uint32 mass;

  // List<SpriteComponent> sprites = new List();
  List<SnakeBody> bodyParts = new List();

  Snake(int length) {
    _createHead(new Offset(150, 250));
    _createBody(length);
  }

  void update(double t) {}

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
    // for (var bodyPart in this.bodyParts) {
    //   bodyPart.move(offset);
    // }

    this.bodyParts[0].move(offset);
  }

  void _createBody(int length) {
    for (int i = 0; i < length; i++) {
      var bodyPart = new SnakeBody(new Offset(0, 30));
      this.bodyParts.add(bodyPart);
    }
  }
}
