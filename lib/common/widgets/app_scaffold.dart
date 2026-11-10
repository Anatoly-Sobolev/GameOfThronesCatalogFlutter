import 'package:flutter/material.dart';

import 'language_toggle_button.dart';
import 'theme_toggle_button.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.body,
    this.showBackButton = false,
    super.key,
  });

  final String title;
  final Widget body;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: showBackButton,
        title: Text(title),
        actions: const [LanguageToggleButton(), ThemeToggleButton()],
      ),
      body: SafeArea(child: body),
    );
  }
}
