import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sr'),
  ];

  /// No description provided for @mozgalica.
  ///
  /// In en, this message translates to:
  /// **'Mozgalica'**
  String get mozgalica;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @leaderboards.
  ///
  /// In en, this message translates to:
  /// **'Leaderboards'**
  String get leaderboards;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @serbian.
  ///
  /// In en, this message translates to:
  /// **'Serbian'**
  String get serbian;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @tttTitle.
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Toe'**
  String get tttTitle;

  /// No description provided for @memoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Memory Game'**
  String get memoryTitle;

  /// No description provided for @mathQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Math Quiz'**
  String get mathQuizTitle;

  /// No description provided for @tttDescription.
  ///
  /// In en, this message translates to:
  /// **'A classic game of Tic Tac Toe. Play against a friend.'**
  String get tttDescription;

  /// No description provided for @tttGameRules.
  ///
  /// In en, this message translates to:
  /// **'The game is played on a 3x3 grid. The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.'**
  String get tttGameRules;

  /// No description provided for @tttRankingRules.
  ///
  /// In en, this message translates to:
  /// **'Each win aword a point.'**
  String get tttRankingRules;

  /// No description provided for @memoryDescription.
  ///
  /// In en, this message translates to:
  /// **'A game of memory. Try to remember the cards.'**
  String get memoryDescription;

  /// No description provided for @memoryGameRules.
  ///
  /// In en, this message translates to:
  /// **'You can flip 2 cards at once. If they match, they will remain flipped. If they don\'t match, they will be turned back over. Try to match all the cards to win the game.'**
  String get memoryGameRules;

  /// No description provided for @memoryRankingRules.
  ///
  /// In en, this message translates to:
  /// **'You will get negative points for every card that is turned over.'**
  String get memoryRankingRules;

  /// No description provided for @mathQuizDescription.
  ///
  /// In en, this message translates to:
  /// **'A game of math. Try to answer the questions.'**
  String get mathQuizDescription;

  /// No description provided for @mathGameRules.
  ///
  /// In en, this message translates to:
  /// **'You will be given a question. Answer it as quickly as possible.'**
  String get mathGameRules;

  /// No description provided for @mathRankingRules.
  ///
  /// In en, this message translates to:
  /// **'You will get a point for every correct answer.'**
  String get mathRankingRules;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @playerName.
  ///
  /// In en, this message translates to:
  /// **'Player name'**
  String get playerName;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'This name will be shown in the game. Keep it short for best layout.'**
  String get nameHint;

  /// No description provided for @gameRules.
  ///
  /// In en, this message translates to:
  /// **'Game Rules'**
  String get gameRules;

  /// No description provided for @rankingRules.
  ///
  /// In en, this message translates to:
  /// **'Ranking Rules'**
  String get rankingRules;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sr':
      return AppLocalizationsSr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
