// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Game of Thrones characters';

  @override
  String get searchHint => 'Search by name';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get tryAnotherQuery => 'Try another query';

  @override
  String get characterNotFound => 'Character not found';

  @override
  String get aliases => 'Aliases';

  @override
  String get titles => 'Titles';

  @override
  String get culture => 'Culture';

  @override
  String get gender => 'Gender';

  @override
  String get born => 'Born';

  @override
  String get playedBy => 'Played by';

  @override
  String get relatedCharacter => 'Related character';

  @override
  String get unknown => 'Unknown';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get changeTheme => 'Change theme';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get back => 'Back';
}
