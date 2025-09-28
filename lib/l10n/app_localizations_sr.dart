// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get mozgalica => 'Mozgalica';

  @override
  String get games => 'Igre';

  @override
  String get leaderboards => 'Rezultati';

  @override
  String get settings => 'Podešavanja';

  @override
  String get english => 'Engleski';

  @override
  String get serbian => 'Srpski';

  @override
  String get clearFilters => 'Obriši filtere';

  @override
  String get tttTitle => 'Iks Oks';

  @override
  String get memoryTitle => 'Igra Memorije';

  @override
  String get mathQuizTitle => 'Matematički Kviz';

  @override
  String get tttDescription =>
      'Klasična igra Iks Oks. Igrajte protiv prijatelja.';

  @override
  String get tttGameRules =>
      'Igra se igra na 3x3 mreži. Igrač koji uspostavi tri svoja znaka u horizontalnoj, vertikalnoj ili dijagonalnoj liniji je pobjednik igre.';

  @override
  String get tttRankingRules => 'Za svaku pobjedu se dobija 1 bod.';

  @override
  String get memoryDescription =>
      'Igra Memorije. Pokušajte da zapamtite kartice.';

  @override
  String get memoryGameRules =>
      'Možete otvoriti 2 kartice odjednom. Ako su iste, ostaju otvorene. Ako nisu iste, vratiće se nazad. Pokušajte da otvorite sve kartice da biste završili igru.';

  @override
  String get memoryRankingRules => 'Za svaki promašaj dobijate negativan bod.';

  @override
  String get mathQuizDescription =>
      'Igra Matematički Kviz. Pokušajte da odgovorite na pitanja.';

  @override
  String get mathGameRules => 'Odgovorite na pitanja najbrže što možete.';

  @override
  String get mathRankingRules => 'Za svaki tačan odgovor se dobija 1 bod.';

  @override
  String get enterYourName => 'Unesite Vaše ime';

  @override
  String get playerName => 'Ime igrača';

  @override
  String get nameHint =>
      'Ovo ime će se prikazati u igri. Ostavite kratko za najbolji izgled.';

  @override
  String get gameRules => 'Pravila igre';

  @override
  String get rankingRules => 'Pravila rangiranja';
}
