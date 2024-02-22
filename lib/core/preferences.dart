import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrale/core/interpolation.dart';
import 'package:wrale/core/language.dart';
import 'package:wrale/core/theme.dart';
import 'package:wrale/core/units.dart';
import 'package:wrale/core/zoom_level.dart';

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

  /// default language
  final Language defaultLanguage = Language.system();

  /// default for theme
  final String defaultTheme = WraleCustomTheme.water.name;

  ///default unit
  final WraleUnit defaultUnit = WraleUnit.kg;

  /// default interpolation strength
  final InterpolStrength defaultInterpolStrength = InterpolStrength.medium;

  /// default zoomLevel
  final ZoomLevel defaultZoomLevel = ZoomLevel.all;

  /// getter and setter for all preferences
// set username
  set userName(String name) => prefs.setString(
        'userName',
        name,
      );

  /// get username
  String get userName => prefs.getString('userName')!;

  // set user height
  set userHeight(double? height) => prefs.setDouble('userHeight', height ?? -1);

  // get user height
  double? get userHeight => prefs.getDouble('userHeight')! > 0
      ? prefs.getDouble('userHeight')!
      : null;

  /// set user target weight
  set userTargetWeight(double? weight) => prefs.setDouble(
        'userTargetWeight',
        weight ?? -1,
      );

  // get user target weight
  double? get userTargetWeight => prefs.getDouble('userTargetWeight')! > 0
      ? prefs.getDouble('userTargetWeight')
      : null;

  // get if onBoarding screen is shown
  bool get showOnBoarding => prefs.getBool('showOnBoarding')!;

  /// set if onBoarding screen is shown
  set showOnBoarding(bool show) => prefs.setBool(
        'showOnBoarding',
        show,
      );

  /// get night mode value
  String get nightMode => prefs.getString('nightMode')!;

  // set night mode value
  set nightMode(String nightMode) => prefs.setString(
        'nightMode',
        nightMode,
      );

  /// get isAmoled value
  bool get isAmoled => prefs.getBool('isAmoled')!;

  // set isAmoled value
  set isAmoled(bool isAmoled) => prefs.setBool(
        'isAmoled',
        isAmoled,
      );

  //get language value
  Language get language => prefs.getString('language')!.toLanguage();

  // set language value
  set language(Language language) => prefs.setString(
        'language',
        language.language,
      );

  /// get theme mode
  String get theme => prefs.getString('theme')!;

  /// set theme mode
  set theme(String theme) => prefs.setString(
        'theme',
        theme,
      );

  /// get unit mode
  WraleUnit get unit => prefs.getString('unit')!.toWraleUnit()!;

  /// set unit mode
  set unit(WraleUnit unit) => prefs.setString(
        'unit',
        unit.name,
      );

  /// get interpolation strength mode
  InterpolStrength get interpolStrength =>
      prefs.getString('interpolStrength')!.toInterpolStrength()!;

  /// set interpolation strength mode
  set interpolStrength(InterpolStrength strength) => prefs.setString(
        'interpolStrength',
        strength.name,
      );

  /// get zoom level
  ZoomLevel get zoomLevel => prefs.getInt('zoomLevel')!.toZoomLevel()!;

  /// set zoom Level
  set zoomLevel(ZoomLevel level) => prefs.setInt(
        'zoomLevel',
        level.index,
      );

  /// set default settings /or reset to default
  void loadDefaultSettings({bool override = false}) {
    if (override || !prefs.containsKey('nightMode')) {
      nightMode = defaultNightMode;
    }
    if (override || !prefs.containsKey('isAmoled')) {
      isAmoled = defaultIsAmoled;
    }
    if (override || !prefs.containsKey('language')) {
      language = defaultLanguage;
    }
    if (override || !prefs.containsKey('theme')) {
      theme = defaultTheme;
    }
    if (override || !prefs.containsKey('unit')) {
      unit = defaultUnit;
    }
    if (override || !prefs.containsKey('interpolStrength')) {
      interpolStrength = defaultInterpolStrength;
    }
    if (override || !prefs.containsKey('userName')) {
      userName = defaultUserName;
    }
    if (override || !prefs.containsKey('userTargetWeight')) {
      userTargetWeight = defaultUserTargetWeight;
    }
    if (override || !prefs.containsKey('userHeight')) {
      userHeight = defaultUserHeight;
    }
    if (override || !prefs.containsKey('showOnBoarding')) {
      showOnBoarding = defaultShowOnBoarding;
    }
    if (override || !prefs.containsKey('zoomLevel')) {
      zoomLevel = defaultZoomLevel;
    }
  }

  void resetSettings() => loadDefaultSettings(override: true);
}
