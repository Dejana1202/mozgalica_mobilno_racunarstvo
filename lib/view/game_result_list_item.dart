import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/model/game_result.dart';
import 'package:mozgalica/service/game_service.dart';
import 'package:mozgalica/service/localization_service.dart';

class GameResultListItem extends StatelessWidget {
  const GameResultListItem({super.key, required this.gameResult});

  final GameResult gameResult;

  //Ovaj widget uzme podatke o jednom rezultatu igre i prikaže ih lijepo u jednoj Card kartici.

  @override
  Widget build(BuildContext context) {
    // pokušamo da nađemo GameModel za ovaj GameResult
    String displayGameTitle;
    try {
      final game = GameService.getAvailableGames().firstWhere(
        (element) => element.id == gameResult.gameId,
      );

      // lokalizovani naziv igre (npr. "Iks Oks" ili "Tic Tac Toe")
      final localizedName =
          GameLocalizationService.getLocalizedTitle(context, game);
    // parametrizovani string iz ARB: "Game: {game}" ili "Igra: {game}"
      displayGameTitle = AppLocalizations.of(context)!.gameWithTitle(localizedName);
    } catch (e) {
      // fallback ako igre nema u listi (prikaži ID igre unutar iste param poruke)
      displayGameTitle = AppLocalizations.of(context)!.gameWithTitle(gameResult.gameId);
    }
    // Card widget za prikaz imena korisnika i rezultata za filtriranu igru 
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full name and score row
            Row(
              children: [
                Expanded(
                  child: Text(
                    gameResult.userName,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  gameResult.score.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Game ID and timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    displayGameTitle,
                    //getGameTitle(),
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(gameResult.timestamp),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getGameTitle() {
    try {
      final game = GameService.getAvailableGames().firstWhere(
        (element) => element.id == gameResult.gameId,
      );

      return "Game: ${game.title}";
    } on Exception catch (e) {
      debugPrint(e.toString());

      return "No game";
    }
  }
}
