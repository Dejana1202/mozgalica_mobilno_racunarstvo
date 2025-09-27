import 'package:mozgalica/model/game_model.dart';

class GameService {
  static const ttt = GameModel(
    id: "ttt",
    title: "Tic Tac Toe",
    description: "Play classic 2-player Tic Tac Toe",
    gameRules: "tttGameRules",
    rankingRules: "tttRankingRules",
    svgIconPath: "assets/tic_tac_toe.svg",
  );

  static const memory = GameModel(
    id: "memory",
    title: "Memory",
    description: "Play classic 1-player Memory",
    gameRules: "memoryGameRules",
    rankingRules: "memoryRankingRules",
    svgIconPath: "assets/memory_cards.svg",
  );

  static const mathQuiz = GameModel(
    id: "math",
    title: "Math Quiz",
    description: "Play classic 1-player Math Quiz",
    gameRules: "mathGameRules",
    rankingRules: "mathRankingRules",
    svgIconPath: "assets/math_quiz.svg",
  );

  static List<GameModel> getAvailableGames() {
    return [ttt, memory, mathQuiz];
  }
}
