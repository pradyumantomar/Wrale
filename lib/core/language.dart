import 'package:flutter/material.dart';

/// tuple holding count and duration
class Language {
  /// constructor
  Language(String locale) : _language = locale;

  /// constructor from Locale
  Language.fromLocale(Locale locale) : _language = locale.languageCode;

  /// constructor from Locale
  Language.system() : _language = systemDefault;

  /// contains country code
  final String _language;

  /// get locale
  Locale get locale => Locale.fromSubtags(languageCode: _language);

  /// get language codec
  String get language => _language;

  @override
  String toString() => 'Language($language)';

  /// default undetermined codec
  static const String systemDefault = 'und';

  /// list of supported locals
  static List<Language> supportedLanguage = <Language>[
    Language.system(),
  ];
}

/// parse time count from number
extension LanguageStringParsing on String {
  /// parsing
  Language toLanguage() => Language(this);
}

/// parse time count from number
extension LanguageLocalParsing on Locale {
  /// parsing
  Language toLanguage() => Language.fromLocale(this);
}
