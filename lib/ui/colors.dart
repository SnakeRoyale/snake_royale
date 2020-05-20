import 'dart:ui';

import 'package:flutter/material.dart';

/// Util class with the game colors.
class GameColors {
  GameColors._();

  /// Primary color.
  static const primary = Color(0xFF000000);

  /// Primary dark color.
  static const primaryDark = Color(0xFF1A2629);

  /// The color of the unplayable area.
  static const voidBackground = Color(0xFF1A2629);

  /// The background of the playable area.
  static const background = Colors.blueAccent;

  /// The color used to draw the chess background.
  static const backgroundChess = Color(0xFF42A5F5);
}
