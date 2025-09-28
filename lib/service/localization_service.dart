import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/main.dart';
import 'package:mozgalica/model/game_model.dart';
import 'package:mozgalica/service/game_service.dart';
import 'package:mozgalica/view/settings_page.dart';

/// This is a variable that stores current app locale. User can change it in [SettingsPage].
/// To get updates about locale changes, listen to it via [ValueListenableBuilder] in [MyApp].
final ValueNotifier<Locale?> appLocale = ValueNotifier<Locale?>(null);

class GameLocalizationService {
  static String getLocalizedTitle(BuildContext context, GameModel game) {
    if (game.id == GameService.ttt.id) {
      return AppLocalizations.of(context)!.tttTitle;
    } else if (game.id == GameService.memory.id) {
      return AppLocalizations.of(context)!.memoryTitle;
    } else if (game.id == GameService.mathQuiz.id) {
      return AppLocalizations.of(context)!.mathQuizTitle;
    }

    return game.title;
  }

  static String getLocalizedDescription(BuildContext context, GameModel game) {
    if (game.id == GameService.ttt.id) {
      return AppLocalizations.of(context)!.tttDescription;
    } else if (game.id == GameService.memory.id) {
      return AppLocalizations.of(context)!.memoryDescription;
    } else if (game.id == GameService.mathQuiz.id) {
      return AppLocalizations.of(context)!.mathQuizDescription;
    }

    return game.description;
  }

  static String getLocalizedGameRules(BuildContext context, GameModel game) {
    if (game.id == GameService.ttt.id) {
      return AppLocalizations.of(context)!.tttGameRules;
    } else if (game.id == GameService.memory.id) {
      return AppLocalizations.of(context)!.memoryGameRules;
    } else if (game.id == GameService.mathQuiz.id) {
      return AppLocalizations.of(context)!.mathGameRules;
    }

    return game.gameRules;
  }

  static String getLocalizedRankingRules(BuildContext context, GameModel game) {
    if (game.id == GameService.ttt.id) {
      return AppLocalizations.of(context)!.tttRankingRules;
    } else if (game.id == GameService.memory.id) {
      return AppLocalizations.of(context)!.memoryRankingRules;
    } else if (game.id == GameService.mathQuiz.id) {
      return AppLocalizations.of(context)!.mathRankingRules;
    }

    return game.rankingRules;
  }
}
