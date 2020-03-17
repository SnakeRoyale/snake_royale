import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';

import 'views/game.dart';
import 'views/game.dart';
import 'views/game.dart';

void main() async {
  Flame.initializeWidget();

  Util flameUtil = Util();

  await flameUtil.fullScreen();
  await flameUtil.setPortraitUpOnly();

  Game game = new Game();
  runApp(game.widget);
}
