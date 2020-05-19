import 'package:flutter/cupertino.dart';

class GameOverScreen extends StatefulWidget {
  bool won;

  GameOverScreen({this.won, Key key}) : super(key: key);

  @override
  _GameOverScreenState createState() => _GameOverScreenState(won: won);
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool won;

  _GameOverScreenState({this.won});

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(),
    );
  }
}
