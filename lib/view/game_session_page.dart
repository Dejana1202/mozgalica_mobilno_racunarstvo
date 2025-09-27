import 'package:flutter/material.dart';
import 'package:mozgalica/model/game_model.dart';

class GameSessionPage extends StatefulWidget {
  const GameSessionPage({super.key, required this.game});

  final GameModel game;

  @override
  State<GameSessionPage> createState() => _GameSessionPageState();
}

class _GameSessionPageState extends State<GameSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.game.title)));
  }
}
