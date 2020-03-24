import 'dart:ffi';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:snake_royale/interfaces/movable.dart';

class SnakeBody implements Movable{
  String name;
  String color;
  Uint32 mass;
  List<SpriteComponent> sprites = new List();

  void update(double t){

  }

  SnakeBody(int length){
    _createHead(new Offset(150, 250));
    _createBody(length);
  }

  void _createHead(Offset offset){
    var circle = Flame.images.loadedFiles['sprites/snakes/default/head.png'];
    Sprite sprite = Sprite.fromImage(circle);
    double size = circle.height.toDouble();
    var headSprite = SpriteComponent.fromSprite(size, size, sprite); // width, height, sprite
    headSprite.x = offset.dx; // 0 by default
    headSprite.y = offset.dy; // 0 by default
    headSprite.angle = 0; // 0 by default
    this.sprites.add(headSprite);
  }

  void _drawBody(Canvas canvas, Offset offset){

  }
  void render(Canvas canvas){
    for(var component in this.sprites){
      component.render(canvas);
    }
  }

  void move(Offset offset){
    for(var component in this.sprites){
      component.x += offset.dx;
      component.y += offset.dy;
    }
  }

  void _createBody(int length) {
    var circle = Flame.images.loadedFiles['sprites/snakes/default/circle.png'];

    for(int i = 0; i < length; i ++){
      Sprite sprite = Sprite.fromImage(circle);
      double size = circle.height.toDouble();
      var bodySprite = SpriteComponent.fromSprite(size, size, sprite); // width, height, sprite
      bodySprite.x = 0; // 0 by default
      bodySprite.y = 30; // 0 by default

      if(i == 0){
        bodySprite.x = -35;
        bodySprite.y = 20; // 0 by default

      }
      bodySprite.angle = 0; // 0 by default
      this.sprites.add(bodySprite);
    }

  }
}
