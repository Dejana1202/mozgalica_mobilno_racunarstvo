class GameModel {
  final String id;
  final String title;
  final String description;
  final String gameRules;
  final String rankingRules;
  final String svgIconPath;

  const GameModel({
    required this.id,
    required this.title,
    required this.description,
    required this.gameRules,
    required this.rankingRules,
    required this.svgIconPath,
  });
}
