import 'package:flutter/material.dart';
import 'package:mozgalica/service/shared_prefrences_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();

    // Read selected language from shared preferences
    selectedLanguage = SharedPreferencesService.getSelectedLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        Text("Language", style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 16),
        DropdownButton<String>(
          items: [
            DropdownMenuItem(value: "English", child: Text("English")),
            DropdownMenuItem(value: "Serbian", child: Text("Serbian")),
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
  }
}
