import 'package:flutter/cupertino.dart';
import 'package:snaake/game/service/highscore_service.dart';
import 'package:snaake/game/service/score_model.dart';

class GameOverScreen extends StatefulWidget {
  bool won;
  int score;

  GameOverScreen({this.won, this.score, Key key}) : super(key: key);

  @override
  _GameOverScreenState createState() =>
      _GameOverScreenState(won: won, score: score);
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool won;
  int score;

  _GameOverScreenState({this.won, this.score});

  @override
  Widget build(BuildContext context) {
    HightscoreService().addScore(ScoreModel(score, DateTime.now()));
    return Center(
      child: Text('you died with $score points. yikes'),
    );
  }
}
