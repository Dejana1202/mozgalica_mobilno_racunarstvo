import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozgalica/model/game_model.dart';
import 'package:mozgalica/service/game_service.dart';
import 'package:mozgalica/view/game_session_page.dart';
import 'package:mozgalica/view/ttt/ttt_player_entry_page.dart';

class GameDetailsPage extends StatelessWidget {
  const GameDetailsPage({super.key, required this.game});

  final GameModel game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(game.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: SvgPicture.asset(game.svgIconPath, height: 200, width: 200),
          ),
          Text(
            game.description,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          Text(
            "Game Rules",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(game.gameRules, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16),
          Text(
            "Ranking Rules",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            game.rankingRules,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: ElevatedButton(
              onPressed: () {
                startGame(context);
              },
              child: Text("PLAY"),
            ),
          ),
        ],
      ),
    );
  }

  void startGame(BuildContext context) {
    if (game.id == GameService.ttt.id) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TTTPlayerEntryPage()),
      );
    } else if (game.id == GameService.memory.id) {
      // Implement this
    } else if (game.id == GameService.mathQuiz.id) {
      // Implement this
    } else {
      // Error - show toast
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Game not implemented")));
    }
  }
}
