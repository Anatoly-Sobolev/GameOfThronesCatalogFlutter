import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  const languageCode = String.fromEnvironment('LOCALE', defaultValue: 'ru');
  runApp(GameOfThronesApp(initialLocale: Locale(languageCode)));
}
