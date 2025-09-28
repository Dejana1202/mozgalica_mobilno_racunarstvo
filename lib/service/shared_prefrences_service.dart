import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late final SharedPreferences prefs;

  static const String _selectedLanguageKey = 'selectedLanguage';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String getSelectedLanguage() =>
      prefs.getString(_selectedLanguageKey) ?? 'English';

  static Future<void> setSelectedLanguage(String language) =>
      prefs.setString(_selectedLanguageKey, language);
}
