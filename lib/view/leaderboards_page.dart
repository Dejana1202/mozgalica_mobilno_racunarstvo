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
  List<GameResult> allGameResults = [];
  List<GameResult> filteredGameResults = [];
  final TextEditingController userSearchController = TextEditingController();
  final TextEditingController gameIdController = TextEditingController();

  @override
  void dispose() {
    userSearchController.dispose();
    gameIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    fetchGameResults();
  }

  void fetchGameResults() async {
    userSearchController.clear();
    gameIdController.clear();
    filterResults();

    setState(() => loading = true);
    allGameResults = await GameService.getResults();
    filteredGameResults = allGameResults;
    setState(() => loading = false);
  }

  void clearUserSearch() {
    userSearchController.clear();
  }

  void clearGameIdFilter() {
    gameIdController.clear();
  }

  void filterResults() {
    final userQuery = userSearchController.text.trim().toLowerCase();
    final gameQuery = gameIdController.text.trim().toLowerCase();

    if (userQuery.isEmpty && gameQuery.isEmpty) {
      setState(
        () => filteredGameResults = List<GameResult>.from(allGameResults),
      );
      return;
    }

    final filtered = allGameResults.where((r) {
      final matchesUser = userQuery.isEmpty
          ? true
          : r.userName.toLowerCase().contains(userQuery);
      final matchesGame = gameQuery.isEmpty
          ? true
          : r.gameId.toLowerCase().contains(gameQuery);
      return matchesUser && matchesGame;
    }).toList();

    setState(() => filteredGameResults = filtered);
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

        // FILTER HEADER
        Card(
          margin: EdgeInsets.only(top: 16, bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // row with two fields
                Row(
                  children: [
                    // Game ID filter
                    Expanded(
                      child: TextField(
                        controller: gameIdController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Filter by game id',
                          labelText: 'Game id',
                          prefixIcon: const Icon(Icons.videogame_asset),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onSubmitted: (_) => filterResults(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // User search
                    Expanded(
                      child: TextField(
                        controller: userSearchController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search by user',
                          labelText: 'User',
                          prefixIcon: const Icon(Icons.person_search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onSubmitted: (_) => filterResults(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // optional quick-filter row: show currently applied filters and a clear-all button
                Row(
                  children: [
                    if (gameIdController.text.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text('Game: ${gameIdController.text}'),
                        ),
                      ),
                    if (userSearchController.text.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text('User: ${userSearchController.text}'),
                        ),
                      ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        userSearchController.clear();
                        gameIdController.clear();
                        filterResults();
                      },
                      icon: const Icon(Icons.clear_all),
                      label: const Text('Clear filters'),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
              itemCount: filteredGameResults.length,
              itemBuilder: (context, index) =>
                  GameResultListItem(gameResult: filteredGameResults[index]),
            ),
          ),
        ),
      ],
    );
  }
}
