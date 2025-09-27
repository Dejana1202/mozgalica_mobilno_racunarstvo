import 'package:flutter/material.dart';
import 'package:mozgalica/view/game_list_item.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Games",
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView(
            children: [
              GameListItem(
                title: "Tic Tac Toe",
                description: "Play classic 2-player Tic Tac Toe",
                onPlay: () {},
                svgIconPath: "assets/tic_tac_toe.svg",
              ),
              // Memory
              GameListItem(
                title: "Memory",
                description: "Play classic 1-player Memory",
                onPlay: () {},
                svgIconPath: "assets/memory_cards.svg",
              ),
              // Math quiz
              GameListItem(
                title: "Math Quiz",
                description: "Play classic 1-player Math Quiz",
                onPlay: () {},
                svgIconPath: "assets/math_quiz.svg",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
