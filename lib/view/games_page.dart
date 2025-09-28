import 'package:flutter/material.dart';
import 'package:mozgalica/service/game_service.dart';
import 'package:mozgalica/view/game_details_page.dart';
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
        Text("Games", style: Theme.of(context).textTheme.headlineLarge),
        Expanded(
          child: ListView(
            children: [
              GameListItem(
                game: GameService.ttt,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GameDetailsPage(game: GameService.ttt),
                    ),
                  );
                },
              ),
              GameListItem(
                game: GameService.memory,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GameDetailsPage(game: GameService.memory),
                    ),
                  );
                },
              ),
              GameListItem(
                game: GameService.mathQuiz,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GameDetailsPage(game: GameService.mathQuiz),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
