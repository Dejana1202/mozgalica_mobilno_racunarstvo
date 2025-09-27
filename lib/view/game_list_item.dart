import 'package:flutter/material.dart';

class GameListItem extends StatelessWidget {
  const GameListItem({
    super.key,
    required this.title,
    required this.description,
    required this.onPlay,
    required this.svgIconPath,
  });

  final String title;
  final String description;
  final Function onPlay;
  final String svgIconPath;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
