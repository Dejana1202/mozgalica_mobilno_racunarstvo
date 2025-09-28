import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/view/games_page.dart';
import 'package:mozgalica/view/leaderboards_page.dart';
import 'package:mozgalica/view/settings_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int selectedIndex = 0;

  void onItemTapped(int newindex) {
    setState(() {
      selectedIndex = newindex;
    });
  }

  Widget getCurrentPage() {
    switch (selectedIndex) {
      case 0:
        return GamesPage();
      case 1:
        return LeaderboardsPage();
      case 2:
        return SettingsPage();
      default:
        return GamesPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.mozgalica)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: getCurrentPage(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: AppLocalizations.of(context)!.games,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: AppLocalizations.of(context)!.leaderboards,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }
}
