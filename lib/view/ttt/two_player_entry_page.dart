import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/service/game_service.dart';
import 'package:mozgalica/service/localization_service.dart';
import 'package:mozgalica/view/ttt/ttt_game_session_page.dart';

class TwoPlayerEntryPage extends StatefulWidget {
  const TwoPlayerEntryPage({super.key});

  @override
  State<TwoPlayerEntryPage> createState() => _TwoPlayerEntryPageState();
}

class _TwoPlayerEntryPageState extends State<TwoPlayerEntryPage> {
  final p1Controller = TextEditingController();
  final p2Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    p1Controller.dispose();
    p2Controller.dispose();
    super.dispose();
  }

  void _startGame() {
    final name1 = p1Controller.text.trim().isEmpty
        ? 'Player 1'
        : p1Controller.text.trim();
    final name2 = p2Controller.text.trim().isEmpty
        ? 'Player 2'
        : p2Controller.text.trim();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TTTGameSessionPage(playerX: name1, playerO: name2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.enterYourName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              TextFormField(
                controller: p1Controller,
                decoration: const InputDecoration(
                  labelText: 'Player X',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                maxLength: 24,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: p2Controller,
                decoration: const InputDecoration(
                  labelText: 'Player O',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                maxLength: 24,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('START GAME'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: _startGame,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  p1Controller.clear();
                  p2Controller.clear();
                },
                child: const Text('CLEAR'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
