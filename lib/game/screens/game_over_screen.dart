import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snaake/game/service/highscore_service.dart';
import 'package:snaake/game/service/score_model.dart';
import 'package:snaake/game/widgets/bezier_clipper.dart';
import 'package:snaake/game/widgets/center_horizontal.dart';

class GameOverScreen extends StatefulWidget {
  bool won;
  int score;

  GameOverScreen({this.won, this.score, Key key}) : super(key: key);

  @override
  _GameOverScreenState createState() =>
      _GameOverScreenState(won: won, score: score);
}

class _GameOverScreenState extends State<GameOverScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  final double startingHeight = 20.0;

  bool won;
  int score;

  _GameOverScreenState({this.won, this.score});

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 280.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.125,
          0.450,
          curve: Curves.ease,
        ),
      ),
    );
    _controller.forward(from: 0.0);
  }

  Widget startButton(String text, Function action) {
    return ButtonTheme(
      height: 50,
      minWidth: 200,
      child: RaisedButton(
        onPressed: action,
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HightscoreService().addScore(ScoreModel(score, DateTime.now()));
    return Scaffold(
      body: AnimatedBuilder(
        builder: (context, anim) {
          return Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipPath(
                    clipper: BezierClipper(animationValue: animation.value),
                    child: Container(
                      height: animation.value,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: CenterHorizontal(
                      Text(
                        won ? 'Ayy!' : 'Yikes!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CenterHorizontal(
                        Text(
                          'Du hast ${won ? 'gewonnen' : 'verloren'}, und dabei',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      CenterHorizontal(
                        Text(
                          '$score Punkt${score == 1 ? '' : 'e'}',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CenterHorizontal(
                        Text(
                          'mit deiner Schlange gesammelt.',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      CenterHorizontal(
                        startButton(
                          'Nochmal spielen',
                          () => Navigator.pushReplacementNamed(context, '/game'),
                        ),
                      ),
                      SizedBox(height: 20),
                      CenterHorizontal(
                        startButton(
                          'Zurück zum Start',
                          () => Navigator.pushReplacementNamed(context, '/start'),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          );
        },
        animation: _controller,
      ),
    );
  }
}
