import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';

import 'views/game.dart';

void main() async {
  Flame.initializeWidget();

  Flame.images.loadAll(<String>[
    'sprites/terrain/food.png',
    'sprites/terrain/hex.png',
    'sprites/terrain/tile.png',
    'sprites/snakes/default/circle.png',
    'sprites/snakes/default/eye-black.png',
    'sprites/snakes/default/eye-white.png',
    'sprites/snakes/default/white-shadow.png',
    'sprites/snakes/default/head.png',
    'joystick/joystick_background.png',
    'joystick/joystick_knob.png',
  ]);

  Util flameUtil = Util();

  await flameUtil.fullScreen();
  await flameUtil.setPortraitUpOnly();

  runApp(App());
}

class App extends StatelessWidget {

  Game game = new Game();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child:
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: game.onPanStart,
            onPanUpdate: game.onPanUpdate,
            onPanEnd: game.onPanEnd,
            child: game.widget,
          ),
      ),
    );
  }
}