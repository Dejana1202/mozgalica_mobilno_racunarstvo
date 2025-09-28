import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Enter Your Name')),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Text(
              'Player name',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => submitName(),
              maxLength: 24,
              decoration: InputDecoration(
                hintText: 'Enter your name',
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
              'This name will be shown in the game. Keep it short for best layout.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),

            const SizedBox(height: 20),

            // Start button
            ElevatedButton(onPressed: submitName, child: const Text('Start')),

            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel/back
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
