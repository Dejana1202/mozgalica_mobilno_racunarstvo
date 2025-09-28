import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';

class LeaderboardsPage extends StatefulWidget {
  const LeaderboardsPage({super.key});

  @override
  State<LeaderboardsPage> createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage> {
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
        //
      ],
    );
  }
}
