import 'package:flutter/material.dart';
import 'package:mozgalica/app_theme.dart';
import 'package:mozgalica/service/localization_service.dart';
import 'package:mozgalica/service/shared_prefrences_service.dart';
import 'package:mozgalica/view/main_menu_page.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();

  final selectedLanguage = SharedPreferencesService.getSelectedLanguage();

  if (selectedLanguage != "") {
    appLocale.value = Locale(selectedLanguage);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder is used to listen to appLocale variable.
    // If appLocale changes, it rebuilds the whole app
    return ValueListenableBuilder(
      valueListenable: appLocale,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Mozgalica',
          theme: appTheme,
          home: const MainMenuPage(),
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
