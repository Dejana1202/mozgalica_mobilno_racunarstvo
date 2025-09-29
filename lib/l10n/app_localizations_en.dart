// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get mozgalica => 'Mozgalica';

  @override
  String get games => 'Games';

  @override
  String get leaderboards => 'Leaderboards';

  @override
  String get settings => 'Settings';

  @override
  String get english => 'English';

  @override
  String get serbian => 'Serbian';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get tttTitle => 'Tic Tac Toe';

  @override
  String get memoryTitle => 'Memory Game';

  @override
  String get mathQuizTitle => 'Math Quiz';

  @override
  String get tttDescription =>
      'A classic game of Tic Tac Toe. Play against a friend.';

  @override
  String get tttGameRules =>
      'The game is played on a 3x3 grid. The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.';

  @override
  String get tttRankingRules => 'Each win aword a point.';

  @override
  String get memoryDescription =>
      'A game of memory. Try to remember the cards.';

  @override
  String get memoryGameRules =>
      'You can flip 2 cards at once. If they match, they will remain flipped. If they don\'t match, they will be turned back over. Try to match all the cards to win the game.';

  @override
  String get memoryRankingRules =>
      'You will get negative points for every card that is turned over.';

  @override
  String get mathQuizDescription =>
      'A game of math. Try to answer the questions.';

  @override
  String get mathGameRules =>
      'You will be given a question. Answer it as quickly as possible.';

  @override
  String get mathRankingRules =>
      'You will get a point for every correct answer.';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get playerName => 'Player name';

  @override
  String get nameHint =>
      'This name will be shown in the game. Keep it short for best layout.';

  @override
  String get gameRules => 'Game Rules';

  @override
  String get rankingRules => 'Ranking Rules';

  @override
  String get allGames => 'All games';

  @override
  String get searchByUser => 'Search by user';

  @override
  String gameWithTitle(Object game) {
    return 'Game: $game';
  }

  @override
  String get language => 'Language';

  @override
  String get playerX => 'Player X';

  @override
  String get playerO => 'Player O';

  @override
  String get clear => 'Clear';

  @override
  String get startGame => 'Start game';

  @override
  String get currentPlayer => 'Current player: ';

  @override
  String get unresolved => 'Unresolved';

  @override
  String get hasWon => 'has won!';

  @override
  String get victory => 'Victory!';

  @override
  String get playAgain => 'Play Again';

  @override
  String get exit => 'Exit';

  @override
  String get newGame => 'New Game';

  @override
  String get home => 'Home';

  @override
  String get cancel => 'Cancel';

  @override
  String get restartGame => 'Restart game';

  @override
  String get score => 'Score';

  @override
  String get time => 'Time';

  @override
  String get questions => 'Questions';

  @override
  String get close => 'Close';

  @override
  String get quizCompleted => 'Quiz Complete';

  @override
  String get moves => 'Moves';

  @override
  String get skip => 'Skip';

  @override
  String get congratulations => 'Congratulations!';
}
