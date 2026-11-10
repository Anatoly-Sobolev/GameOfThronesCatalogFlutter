// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Персонажи Игры престолов';

  @override
  String get searchHint => 'Поиск по имени';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get tryAnotherQuery => 'Попробуйте изменить запрос';

  @override
  String get characterNotFound => 'Персонаж не найден';

  @override
  String get aliases => 'Прозвища';

  @override
  String get titles => 'Титулы';

  @override
  String get culture => 'Культура';

  @override
  String get gender => 'Пол';

  @override
  String get born => 'Родился';

  @override
  String get playedBy => 'Актёр';

  @override
  String get father => 'Отец';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get male => 'Мужской';

  @override
  String get female => 'Женский';

  @override
  String get changeTheme => 'Сменить тему';

  @override
  String get changeLanguage => 'Сменить язык';
}
