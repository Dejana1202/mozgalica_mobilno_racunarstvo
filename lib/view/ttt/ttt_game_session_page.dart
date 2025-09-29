import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/model/game_result.dart';
import 'package:mozgalica/service/game_service.dart';

class TTTGameSessionPage extends StatefulWidget {
  final String playerX;
  final String playerO;

  const TTTGameSessionPage({
    super.key,
    required this.playerX,
    required this.playerO,
  });

  @override
  State<TTTGameSessionPage> createState() => _TTTGameSessionPageState();
}

class _TTTGameSessionPageState extends State<TTTGameSessionPage> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true; // X starts
  bool gameOver = false;
  String? winner; // 'X' or 'O' or 'draw'

  static const List<List<int>> winningCombos = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
      gameOver = false;
      winner = null;
    });
  }

  void handleTap(int index) {
    if (board[index].isNotEmpty || gameOver) return;
    final currentSymbol = isXTurn ? 'X' : 'O';
    board[index] = currentSymbol;
    final winnerPlayerName = checkGameState();
    if (winnerPlayerName != null) {
      // 3️⃣ Ako je kraj igre, pokaži dijalog
      showEndDialog(winnerPlayerName);
    } else {
      // 4️⃣ Ako igra nije gotova, promeni turn
      setState(() {
        isXTurn = !isXTurn;
      });
    }


  }

String? checkGameState() {
    // Check winner
    for (var combo in winningCombos) {
      final a = combo[0], b = combo[1], c = combo[2];
      if (board[a].isNotEmpty && board[a] == board[b] && board[a] == board[c]) {
        gameOver = true;
        winner = board[a];

         final winnerPlayerName = winner == 'X' ? widget.playerX : widget.playerO;

        GameService.saveResult(
    GameResult(
      userName: winnerPlayerName,
      score: 1,
      gameId: GameService.ttt.id,
      timestamp: DateTime.now(),
    ),
  );
        return winnerPlayerName;

      }
    }

    // Check Draw
    if (!board.contains('')) {
      gameOver = true;
      winner = 'draw';
          return AppLocalizations.of(context)!.unresolved;
    }
    return null; // igra nije gotova
  }


  void showEndDialog(String winnerPlayerName) {
    final title = winner == 'draw'
      ? AppLocalizations.of(context)!.unresolved
      : AppLocalizations.of(context)!.victory;

      final content = winner == 'draw'
      ? AppLocalizations.of(context)!.unresolved
      : '$winnerPlayerName ${AppLocalizations.of(context)!.hasWon}';


    Future.microtask(() {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetBoard();
              },
              child: Text(AppLocalizations.of(context)!.playAgain),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).popUntil((route) => route.isFirst); // Select game();
              },
              child: Text(AppLocalizations.of(context)!.exit),
            ),
          ],
        ),
      );
    });
  }

  Widget buildCell(int index) {
    final val = board[index];
    return GestureDetector(
      onTap: () => handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo.shade700),
          color: Colors.indigo.shade50,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Text(
              val,
              key: ValueKey(val + index.toString()),
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: val == 'X'
                    ? Colors.indigo.shade900
                    : Colors.orange.shade800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayerName = isXTurn ? widget.playerX : widget.playerO;
    final currentSymbol = isXTurn ? 'X' : 'O';

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tttTitle),
        actions: [
          IconButton(
            tooltip: 'RESET',
            onPressed: () {
              resetBoard();
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 6),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  '${widget.playerX} (X)  —  ${widget.playerO} (O)',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${AppLocalizations.of(context)!.currentPlayer} $currentPlayerName ($currentSymbol)',
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Table 3x3
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (_, idx) => buildCell(idx),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('New Game'),
                    onPressed: () => resetBoard(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.home),
                    label: const Text('Home'),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
