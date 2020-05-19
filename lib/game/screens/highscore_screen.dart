import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snaake/game/widgets/bezier_clipper.dart';

class HighscoreScreen extends StatefulWidget {
  final double height;

  // ignore: public_member_api_docs
  HighscoreScreen(this.height);

  @override
  _HighscoreScreenState createState() => _HighscoreScreenState();
}

class _HighscoreScreenState extends State<HighscoreScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  final double startingHeight  =20.0;

  @override
  void initState() {
    // TODO: implemnt initState
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(
      begin: 50.0,
      end: 280.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.125, 0.450,
          curve: Curves.ease,
        ),
      ),
    );
    _controller.forward(from: 0.0);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        builder: (context, anim) {
          return ClipPath(
            clipper: BezierClipper(animationValue: animation.value),
            child: Container(
              height: animation.value,
              color: Colors.blueAccent,
            ),
          );
        },
        animation: _controller,
      ),
    );
  }
}
