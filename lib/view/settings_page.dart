import 'package:flutter/material.dart';
import 'package:mozgalica/l10n/app_localizations.dart';
import 'package:mozgalica/service/localization_service.dart';
import 'package:mozgalica/service/shared_prefrences_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = "en";

  @override
  void initState() {
    super.initState();

    // Read selected language from shared preferences to check if user has set the language before.
    selectedLanguage = SharedPreferencesService.getSelectedLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        Text(
          AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        Text("Language", style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 16),
        DropdownButton<String>(
          items: [
            DropdownMenuItem(
              value: "en",
              child: Text(AppLocalizations.of(context)!.english),
            ),
            DropdownMenuItem(
              value: "sr",
              child: Text(AppLocalizations.of(context)!.serbian),
            ),
          ],
          onChanged: (value) {
            changeSelectedLanguage(value);
          },
          isExpanded: true,
          value: selectedLanguage,
        ),
        //
      ],
    );
  }

  void changeSelectedLanguage(String? value) {
    setState(() {
      selectedLanguage = value!;
    });
    // Save selected language to shared preferences
    SharedPreferencesService.setSelectedLanguage(selectedLanguage);

    // Update appLocale variable to reload the whole app
    appLocale.value = Locale(selectedLanguage);
  }
}
