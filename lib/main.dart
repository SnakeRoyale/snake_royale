import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaake/game/screens/game_over_screen.dart';
import 'package:snaake/game/screens/highscore_screen.dart';
import 'package:snaake/game/screens/start_screen.dart';

import './game/blocs/game_bloc.dart';
import './game/flame/flame_manager.dart';
import './game/screens/game_screen.dart';
import './ui/colors.dart';

void main() => runApp(MainApp());

/// Main application.
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); // Hide Android status bar
    return MaterialApp(
      title: 'Snake Royale',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: GameColors.primary,
        primaryColorDark: GameColors.primary,
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => StartScreen(),
        '/highscore': (context) => HighscoreScreen(MediaQuery.of(context).size.height),
        '/gameover': (context) => GameOverScreen(won: false),
        '/win': (context) => GameOverScreen(won: true),
        '/game': (context) => BlocProvider(
              create: (context) => GameBloc(
                flameManager: FlameManager(),
                random: Random(),
              ),
              child: GameScreen(),
            )
      },
    );
  }
}
