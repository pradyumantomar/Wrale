import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrale/core/language.dart';
import 'package:wrale/core/theme.dart';
import 'package:wrale/core/units.dart';

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

  // default for userTargetWeight in kg
  final double defaultUserTargetWeight = -1;

  // default for userTargetWeight in kg
  final double defaultUserWeight = 70;

  // default for userHeight in m
  final double defaultUserHeight = -1;

  // default for show onBoarding screen
  final bool defaultShowOnBoarding = true;

  /// default for nightMode setting
  final String defaultNightMode = 'auto';

  /// default for isAmoled
  final bool defaultIsAmoled = false;

  //show onBoardingPage to user
  final bool showOnBoarding = true;

  /// default language
  final Language defaultLanguage = Language.system();

  /// default for theme
  final String defaultTheme = WraleCustomTheme.water.name;

  ///default unit
  final WraleUnit defaultUnit = WraleUnit.kg;

  /// default interpolation strength
  // final Interpolation defaultInterpolationStrength = InterpolStrength.medium;

  ///

  /// set if onBoarding screen is shown
  set showOnBoarding(bool show) => prefs.setBool('showOnBoarding', show);

// set username
  set userName(String name) => prefs.setString('userName', name);

  /// get username

  String get userName => prefs.getString('userName')!;

  void loadDefaultSettings({bool override = false}) {
    if (override || !prefs.containsKey('userName')) {
      userName = defaultUserName;
    }
  }

  void resetSettings() => loadDefaultSettings(override: true);
}
