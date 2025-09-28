import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/model/game_result.dart';
import 'package:mozgalica/service/game_service.dart';
import 'package:mozgalica/view/game_result_list_item.dart';

class LeaderboardsPage extends StatefulWidget {
  const LeaderboardsPage({super.key});

  @override
  State<LeaderboardsPage> createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage> {
  bool loading = false;
  List<GameResult> gameResults = [];

  @override
  void initState() {
    super.initState();

    fetchGameResults();
  }

  void fetchGameResults() async {
    setState(() => loading = true);
    gameResults = await GameService.getResults();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        Text(
          AppLocalizations.of(context)!.leaderboards,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        if (loading)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => fetchGameResults(),
            child: ListView.builder(
              itemCount: gameResults.length,
              itemBuilder: (context, index) =>
                  GameResultListItem(gameResult: gameResults[index]),
            ),
          ),
        ),
      ],
    );
  }
}
