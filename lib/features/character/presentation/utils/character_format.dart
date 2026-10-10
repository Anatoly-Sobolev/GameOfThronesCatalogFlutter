import '../../../../l10n/app_localizations.dart';

extension CharacterGenderFormat on String {
  String genderLabel(AppLocalizations strings) => switch (this) {
    'Male' => strings.male,
    'Female' => strings.female,
    _ => strings.unknown,
  };
}

extension CharacterValueFormat on String {
  String valueOrUnknown(AppLocalizations strings) {
    return isEmpty || this == 'Unknown' ? strings.unknown : this;
  }
}

extension CharacterValuesFormat on List<String> {
  String valuesOrUnknown(AppLocalizations strings) {
    return isEmpty ? strings.unknown : join(', ');
  }
}
