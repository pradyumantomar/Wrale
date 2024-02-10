import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrale/core/language.dart';

/// Class to coordinate shared preferences access
class Preferences {
  ///singleton constructor
  factory Preferences() => _instances;

  /// single instance creation
  Preferences._internal() {
    _loaded = loadPreferences();
  }

  /// load preferences
  Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadDefaultSettings();
  }

  /// if shared preferences finished to load
  Future<void>? get loaded => _loaded;
  Future<void>? _loaded;

  /// singleton instance
  static final Preferences _instances = Preferences._internal();

  ///shared preference instance
  late SharedPreferences prefs;

  /// default values
  /// default for userName
  final String defaultUserName = '';

  /// default for nightMode setting
  final String defaultNightMode = 'auto';

  /// default for isAmoled
  final bool defaultIsAmoled = false;

  //show onBoardingPage to user
  final bool showOnBoarding = true;

  /// set if onBoarding screen is shown
  set showOnBoarding(bool show) => prefs.setBool('showOnBoarding', show);

  /// default language
  final Language defaultLanguage = Language.system();

  void loadDefaultSettings({bool override = false}) {}

  void resetSettings() => loadDefaultSettings(override: true);
}
