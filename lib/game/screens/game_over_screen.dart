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

  bool won;
  int score;

  _GameOverScreenState({this.won, this.score});

  @override
  Widget build(BuildContext context) {
    HightscoreService().addScore(ScoreModel(score, DateTime.now()));
    return Scaffold(
      body: AnimatedBuilder(
        builder: (context, anim) {
          return Stack(
            children: <Widget>[
              ClipPath(
                clipper: BezierClipper(animationValue: animation.value),
                child: Container(
                  height: animation.value,
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: CenterHorizontal(
                  Text(
                    'Highscores',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text(''),
                  // You can add title here
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.blue.withOpacity(0.3),
                  //You can make this transparent
                  elevation: 0.0, //No shadow
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 230, horizontal: 30),
                child: ListView(
                  children: [],
                ),
              )
            ],
          );
        },
        animation: _controller,
      ),
    );
    // return Center(
    //   child: Text('you died with $score points. yikes'),
    // );
  }
}
