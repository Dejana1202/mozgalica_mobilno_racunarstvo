import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mozgalica/model/game_result.dart';
import 'package:mozgalica/service/game_service.dart';

class MemoryGameSessionPage extends StatefulWidget {
  const MemoryGameSessionPage({super.key, required this.playerName});

  final String playerName;

  @override
  MemoryGameSessionPageState createState() => MemoryGameSessionPageState();
}

class MemoryGameSessionPageState extends State<MemoryGameSessionPage> {
  // Config
  static const int pairsCount = 9; // number of pairs
  late List<CardModel> cards;
  List<int> openedIndices = [];
  Set<int> matchedIndices = {};
  int moves = 0;
  bool busy = false;

  // Timer
  late Stopwatch stopwatch;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startNewGame() {
    final baseSymbols = <String>[
      '🍎',
      '🍌',
      '🍇',
      '🍓',
      '🍍',
      '🥝',
      '🍑',
      '🍒',
      '🥥',
      '🍊',
      '🍉',
      '🍋',
      '🍈',
      '🍆',
    ];

    final rand = Random();
    final symbols = (List<String>.from(
      baseSymbols,
    )..shuffle(rand)).take(pairsCount).toList();

    final full = <CardModel>[];
    for (var s in symbols) {
      full.add(CardModel(content: s, id: UniqueKey().hashCode));
      full.add(CardModel(content: s, id: UniqueKey().hashCode));
    }
    full.shuffle(rand);

    cards = full;
    openedIndices.clear();
    matchedIndices.clear();
    moves = 0;
    busy = false;

    timer?.cancel();
    stopwatch = Stopwatch()..start();
    timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (mounted) setState(() {});
    });

    setState(() {});
  }

  String get elapsedTime {
    final ms = stopwatch.elapsedMilliseconds;
    final s = (ms / 1000).floor();
    final minutes = (s ~/ 60).toString().padLeft(2, '0');
    final seconds = (s % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> onCardTap(int index) async {
    if (busy) return;
    if (matchedIndices.contains(index)) return;
    if (openedIndices.contains(index)) return;

    setState(() => openedIndices.add(index));

    if (openedIndices.length == 2) {
      moves++;
      final first = openedIndices[0];
      final second = openedIndices[1];

      if (cards[first].content == cards[second].content) {
        matchedIndices.add(first);
        matchedIndices.add(second);
        openedIndices.clear();

        if (matchedIndices.length == cards.length) {
          stopwatch.stop();
          timer?.cancel();
          // small delay so flip animation completes
          await Future.delayed(const Duration(milliseconds: 400));
          if (!mounted) return;

          GameService.saveResult(
            GameResult(
              userName: widget.playerName,
              score: moves * (-1),
              gameId: GameService.memory.id,
              timestamp: DateTime.now(),
            ),
          );

          showWinDialog();
        }
      } else {
        busy = true;
        await Future.delayed(const Duration(milliseconds: 700));
        if (!mounted) return;
        setState(() => openedIndices.clear());
        busy = false;
      }
    }
  }

  Future<void> showWinDialog() async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Text(
          'You completed the game in $elapsedTime (moves: $moves).',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startNewGame();
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget buildCard(int index) {
    final model = cards[index];
    final isOpened = openedIndices.contains(index);
    final isMatched = matchedIndices.contains(index);

    return GestureDetector(
      onTap: () => onCardTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(6),
        child: FlipCard(
          front: CardFaceFront(content: model.content, matched: isMatched),
          back: CardFaceBack(disabled: isMatched),
          showBack: isOpened || isMatched,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = (width ~/ 90).clamp(2, 6);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Quiz'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Restart',
            onPressed: startNewGame,
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: Column(
        children: [
          // Info bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text('Moves: $moves', style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 16),
                Text(
                  'Time: $elapsedTime',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: startNewGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text('New Game'),
                ),
              ],
            ),
          ),

          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) => buildCard(index),
            ),
          ),

          // footer / hint
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Pairs: $pairsCount • Tap a card to flip it.',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class CardModel {
  final String content;
  final int id;
  CardModel({required this.content, required this.id});
}

class CardFaceFront extends StatelessWidget {
  final String content;
  final bool matched;
  const CardFaceFront({required this.content, this.matched = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: matched ? 8 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text(content, style: const TextStyle(fontSize: 28))),
    );
  }
}

class CardFaceBack extends StatelessWidget {
  final bool disabled;
  const CardFaceBack({this.disabled = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: disabled
          ? Colors.green[200]
          : Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Center(
        child: Icon(Icons.help_outline, size: 32, color: Colors.white),
      ),
    );
  }
}

class FlipCard extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool showBack;
  const FlipCard({
    required this.front,
    required this.back,
    required this.showBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
        return AnimatedBuilder(
          animation: rotateAnim,
          child: child,
          builder: (context, child) {
            final angle = rotateAnim.value;
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle);
            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: child,
            );
          },
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: showBack
          ? KeyedSubtree(key: const ValueKey(1), child: front)
          : KeyedSubtree(key: const ValueKey(2), child: back),
    );
  }
}
