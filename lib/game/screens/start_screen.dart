import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
margin: EdgeInsets.symmetric(vertical: 200),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('game'),
            onPressed: () => Navigator.pushNamed(context, '/game'),
          ),
          RaisedButton(
            child: Text('highscore'),
            onPressed: () => Navigator.pushNamed(context, '/highscore'),
          )
        ],
      ),
    );
  }
}
