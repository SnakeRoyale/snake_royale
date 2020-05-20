import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snaake/game/widgets/bezier_clipper.dart';
import 'package:snaake/game/widgets/center_horizontal.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
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
      end: 500.0,
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
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, anim) {
          return Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: <Widget>[
              ClipPath(
                clipper: BezierClipper(animationValue: animation.value),
                child: Container(
                  height: animation.value,
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 75),
                child: Column(
                  children: <Widget>[
                    CenterHorizontal(
                      Image(
                        height: 150,
                        image: AssetImage('assets/gif/royalty.gif'),
                      ),
                    ),
                    CenterHorizontal(
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'Snake Royale',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(60, 550, 60, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    startButton(
                      'Spiel starten',
                      () => Navigator.pushNamed(context, '/game'),
                    ),
                    SizedBox(height: 20),
                    startButton(
                      'Highscores',
                      () => Navigator.pushNamed(context, '/highscore'),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
