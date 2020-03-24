import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';

import 'views/game.dart';
import 'views/game.dart';
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

  ]);

  Util flameUtil = Util();

  await flameUtil.fullScreen();
  await flameUtil.setPortraitUpOnly();

  Game game = new Game();
  runApp(game.widget);
}
