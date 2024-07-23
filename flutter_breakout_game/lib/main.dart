import 'package:flutter/material.dart';
import 'package:flutter_breakout_game/view/game_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Breakout Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameView(),
    );
  }
}