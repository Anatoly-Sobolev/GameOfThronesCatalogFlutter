import 'dart:convert';
import 'dart:io';

void main() {
  final russianKeys = _readKeys('lib/l10n/app_ru.arb');
  final englishKeys = _readKeys('lib/l10n/app_en.arb');

  final missingInEnglish = russianKeys.difference(englishKeys).toList()..sort();
  final missingInRussian = englishKeys.difference(russianKeys).toList()..sort();

  if (missingInEnglish.isNotEmpty || missingInRussian.isNotEmpty) {
    if (missingInEnglish.isNotEmpty) {
      stderr.writeln('Нет в app_en.arb: ${missingInEnglish.join(', ')}');
    }
    if (missingInRussian.isNotEmpty) {
      stderr.writeln('Нет в app_ru.arb: ${missingInRussian.join(', ')}');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'OK: обе локали содержат ${russianKeys.length} одинаковых ключей.',
  );
}

Set<String> _readKeys(String path) {
  final json =
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return json.keys.where((key) => !key.startsWith('@')).toSet();
}
