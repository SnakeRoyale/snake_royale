import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:snake_royale/views/game.dart';

main() async {
  Flame.initializeWidget();
  runApp(new Game().widget);
}