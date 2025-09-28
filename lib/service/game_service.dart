import 'package:flutter/rendering.dart';
import 'package:mozgalica/model/game_model.dart';
import 'package:mozgalica/model/game_result.dart';
import 'package:sqflite/sqflite.dart';

class GameService {
  static Database? _database;

  // Create init method
  static Future<void> init() async {
    _database = await openDatabase(
      '${await getDatabasesPath()}\\results_db.db',
      version: 1,
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE gameResults(id INTEGER PRIMARY KEY, userName TEXT, gameId TEXT, score INTEGER, timestamp TEXT)',
        );
      },
    );
  }

  static const ttt = GameModel(
    id: "ttt",
    title: "tttTitle",
    description: "",
    gameRules: "",
    rankingRules: "",
    svgIconPath: "assets/tic_tac_toe.svg",
  );

  static const memory = GameModel(
    id: "memory",
    title: "Memory",
    description: "",
    gameRules: "",
    rankingRules: "",
    svgIconPath: "assets/memory_cards.svg",
  );

  static const mathQuiz = GameModel(
    id: "math",
    title: "Math Quiz",
    description: "",
    gameRules: "",
    rankingRules: "",
    svgIconPath: "assets/math_quiz.svg",
  );

  static List<GameModel> getAvailableGames() {
    return [ttt, memory, mathQuiz];
  }

  static Future<bool> saveResult(GameResult result) async {
    final db = _database?.database;
    if (db == null) {
      debugPrint("Database not initialized");
      return false;
    }

    await db.insert(
      'gameResults',
      result.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  static Future<List<GameResult>> getResults() async {
    final db = _database?.database;
    if (db == null) {
      debugPrint("Database not initialized");
      return [];
    }

    final List<Map<String, dynamic>> gameResultListDb = await db.query(
      'gameResults',
      orderBy: 'timestamp DESC',
    );
    return List.generate(
      gameResultListDb.length,
      (index) => GameResult.fromMap(gameResultListDb[index]),
    );
  }
}
