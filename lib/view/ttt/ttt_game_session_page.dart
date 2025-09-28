import 'package:flutter/material.dart';
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

    setState(() {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
    });

    checkGameState();
  }

  void checkGameState() {
    // Check winner
    for (var combo in winningCombos) {
      final a = combo[0], b = combo[1], c = combo[2];
      if (board[a].isNotEmpty && board[a] == board[b] && board[a] == board[c]) {
        gameOver = true;
        winner = board[a];

        GameService.saveResult(
          GameResult(
            userName: winnerName(),
            score: 1,
            gameId: GameService.ttt.id,
            timestamp: DateTime.now(),
          ),
        );

        showEndDialog();
        return;
      }
    }

    // Check Draw
    if (!board.contains('')) {
      gameOver = true;
      winner = 'draw';
      showEndDialog();
    }
  }

  String winnerName() {
    if (winner == 'X') return widget.playerX;
    if (winner == 'O') return widget.playerO;
    return 'Nobody (unresolved)';
  }

  void showEndDialog() {
    final title = winner == 'draw' ? 'Draw!' : 'Victory!';
    final content = winner == 'draw'
        ? 'It\'s a draw.'
        : '${winnerName()} has won${winner == 'X' || winner == 'O' ? '!' : '.'}';

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
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).popUntil((route) => route.isFirst); // Select game();
              },
              child: const Text('EXIT'),
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
        title: const Text('Tic Tac Toe'),
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
                  'Current Player: $currentPlayerName ($currentSymbol)',
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
