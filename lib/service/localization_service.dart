import 'package:flutter/material.dart';
import 'package:mozgalica/main.dart';
import 'package:mozgalica/view/settings_page.dart';

/// This is a variable that stores current app locale. User can change it in [SettingsPage].
/// To get updates about locale changes, listen to it via [ValueListenableBuilder] in [MyApp].
final ValueNotifier<Locale?> appLocale = ValueNotifier<Locale?>(null);
