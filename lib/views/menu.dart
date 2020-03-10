import 'package:flutter/material.dart';

class SnakeMenu extends StatefulWidget {
  @override
  _SnakeMenuState createState() => _SnakeMenuState();
}

class _SnakeMenuState extends State<SnakeMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Snake Royale'),
        ),
        body: SafeArea(
          bottom: false,
          child: Container(child: MaterialButton(child: Text("Play"),)),
        ),
      ),
    );
  }
}