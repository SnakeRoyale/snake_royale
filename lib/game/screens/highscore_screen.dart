import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:snaake/game/service/highscore_service.dart';
import 'package:snaake/game/service/score_model.dart';
import 'package:snaake/game/widgets/bezier_clipper.dart';
import 'package:snaake/game/widgets/center_horizontal.dart';
import 'dart:developer' as developer;

class HighscoreScreen extends StatefulWidget {
  final double height;
  final highscoreService = HightscoreService();

  // ignore: public_member_api_docs
  HighscoreScreen(this.height);

  @override
  _HighscoreScreenState createState() => _HighscoreScreenState();
}

class _HighscoreScreenState extends State<HighscoreScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  final double startingHeight = 20.0;

  List<ScoreModel> scores = [];

  @override
  void initState() {
    // TODO: implemnt initState
    super.initState();

    this.widget.highscoreService.getHighscores().then((value) {
      setState(() {
        scores = value;
      });
    });
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
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

  List<Widget> getHighscoreItems() {
    print('called');
    List<Widget> widgets = [];
    int i = 1;
    for (var score in scores) {
      widgets.add(Row(
        children: [
          Text('$i. Punkte', style: TextStyle(fontSize: 20)),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5),),
          Text(score.points.toString(), style: TextStyle(fontSize: 20)),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5),),
          Text('Am ${score.date.day}.${score.date.month}.${score.date.year}', style: TextStyle(fontSize: 20))
        ],
      ));
    }
    print(widgets);
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
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
                    'Highscore',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 35),
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
                  children: getHighscoreItems(),
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
