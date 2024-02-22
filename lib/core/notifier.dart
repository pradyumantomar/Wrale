import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:wrale/core/database.dart';
import 'package:wrale/core/interpolation.dart';
import 'package:wrale/core/language.dart';
import 'package:wrale/core/preferences.dart';
import 'package:wrale/core/theme.dart';
import 'package:wrale/core/units.dart';
import 'package:wrale/core/zoom_level.dart';

/// Class to dynamically change themeMode , isAmoled and language
/// within app
class WraleNotifier with ChangeNotifier {
  // empty constructor, in main.dart load preferences is called first
  WraleNotifier();

  /// call notifier
  void get notify => notifyListeners();

  /// shared preferences instance
  final Preferences prefs = Preferences();

  ///getter
  ThemeMode get themeMode => prefs.nightMode.toThemeMode();

  /// setter
  set themeMode(ThemeMode mode) {
    if (mode != themeMode) {
      prefs.nightMode = mode.toCustomString();
      notify;
    }
  }

  // getter
  bool get isAmoled => prefs.isAmoled;

  // setter
  set isAmoled(bool amoled) {
    if (amoled != isAmoled) {
      prefs.isAmoled = amoled;
      notify;
    }
  }

//getter
  WraleCustomTheme get theme =>
      prefs.theme.toWraleCustomTheme() ??
      prefs.defaultTheme.toWraleCustomTheme()!;

// setter
  set theme(WraleCustomTheme newTheme) {
    if (newTheme != theme) {
      prefs.theme = newTheme.name;
      notify;
    }
  }

  /// get zoom level
  ZoomLevel get zoomLevel => prefs.zoomLevel;

  /// choose next Zoom level
  void nextZoomLevel() {
    final ZoomLevel newLevel = prefs.zoomLevel.next;
    if (newLevel != prefs.zoomLevel) {
      prefs.zoomLevel = newLevel;
      notify;
    }
  }

  /// getter
  Language get language => prefs.language;

  /// setter
  set language(Language newLanguage) {
    if (language != newLanguage) {
      prefs.language = newLanguage;
      notify;
    }
  }

  /// getter
  DateFormat dateFormat(BuildContext context) {
    final Locale activeLocale = Localizations.localeOf(context);
    if (dateTimePatternMap().containsKey(activeLocale.languageCode)) {
      final Map<String, String> dateTimeLocalMap =
          dateTimePatternMap()[activeLocale.languageCode]!;

      if (dateTimeLocalMap.containsKey('yMd')) {
        return DateFormat(dateTimeLocalMap['ymd']!
            .replaceFirst('d', 'dd')
            .replaceFirst('M', 'MM'));
      }
    }
    return DateFormat('dd/MM/yyyy');
  }

  /// getter
  WraleUnit get unit => prefs.unit;

  /// setter
  set unit(WraleUnit newUnit) {
    if (unit != newUnit) {
      prefs.unit = newUnit;
      notify;
    }
  }

  /// getter
  String get userName => prefs.userName;

  /// setter
  set userName(String newName) {
    if (userName != newName) {
      prefs.userName = newName;
      notify;
    }
  }

  /// getter
  double? get userTargetWeight => prefs.userTargetWeight;

  // setter
  set useTargetWeight(double? newWeight) {
    if (userTargetWeight != newWeight) {
      prefs.userTargetWeight = newWeight;
      notify;
    }
  }

  /// get user height in [m]
  double? get userHeight => prefs.userHeight;
  // set user height in [m]
  set userHeight(double? newHeight) {
    if (userHeight != newHeight) {
      prefs.userHeight = newHeight;
      notify;
    }
  }

  /// getter
  InterpolStrength get interpolStrength => prefs.interpolStrength;

  /// setter
  set interpolStrength(InterpolStrength strength) {
    if (interpolStrength != strength) {
      prefs.interpolStrength = strength;
      MeasurementDatabase().reinit();
      notify;
    }
  }

  // getter
  bool get showOnBoarding => prefs.showOnBoarding;

  // setter
  set showOnBoarding(bool onBoarding) {
    if (onBoarding != showOnBoarding) {
      prefs.showOnBoarding = onBoarding;
      notify;
    }
  }

  ColorScheme? _systemLightDynamic;
  ColorScheme? _systemDarkDynamic;

  Color get systemSeedColor =>
      systemColorsAvailable ? _systemLightDynamic!.primary : Colors.black;

  /// set system color accent
  void setColorScheme(ColorScheme? systemLight, ColorScheme? systemDark) {
    _systemDarkDynamic = systemDark;
    _systemLightDynamic = systemLight;
  }

  /// If system accent color is available (Android Os 12+)
  bool get systemColorsAvailable =>
      _systemDarkDynamic != null && _systemLightDynamic != null;

  /// get locale
  Locale? get locale =>
      language.compareTo(Language.system()) ? null : language.locale;

  // factory reset
  Future<void> factoryReset() async {
    prefs.resetSettings();
    await MeasurementDatabase().deleteAllMeasurements();
    notify;
  }
}
