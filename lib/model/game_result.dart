class GameResult {
  final String userName;
  final int score;
  final String gameId;
  final DateTime timestamp;

  GameResult({
    required this.userName,
    required this.score,
    required this.gameId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'userName': userName,
    'score': score,
    'gameId': gameId,
    'timestamp': timestamp.toUtc().toIso8601String(),
  };

  factory GameResult.fromMap(Map<String, dynamic> map) => GameResult(
    userName: map['userName'] as String,
    score: map['score'] as int,
    gameId: map['gameId'] as String,
    timestamp: DateTime.parse(map['timestamp'] as String).toLocal(),
  );
}
