import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';

class SinglePlayerEntryPage extends StatefulWidget {
  const SinglePlayerEntryPage({super.key, required this.onSubmitName});

  final Function onSubmitName;

  @override
  SinglePlayerEntryPageState createState() => SinglePlayerEntryPageState();
}

class SinglePlayerEntryPageState extends State<SinglePlayerEntryPage> {
  final TextEditingController nameController = TextEditingController(text: '');

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void submitName() {
    final playerName = nameController.text.trim();
    if (playerName.isEmpty) return;

    widget.onSubmitName(playerName);
  }

  void clearName() {
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.enterYourName)),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.playerName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => submitName(),
              maxLength: 24,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterYourName,
                prefixIcon: const Icon(Icons.person),
                suffixIcon: nameController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: clearName,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.nameHint,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),

            const SizedBox(height: 20),

            // Start button
            ElevatedButton(onPressed: submitName, child: Text(AppLocalizations.of(context)!.startGame)),

            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel/back
              child: Text(AppLocalizations.of(context)!.restartGame),
            ),
          ],
        ),
      ),
    );
  }
}
