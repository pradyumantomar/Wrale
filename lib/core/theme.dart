import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/notifier.dart';

// get color (black or white ) with maximal constrast or minimal (inverse = false)
Color getFontColor(Color color, {bool inverse = true}) {
  return isDarkColor(color) == inverse ? Colors.white : Colors.black;
}

/// check if color is closer to black or white
bool isDarkColor(Color color) {
  final double luminance =
      0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue;

  return luminance < 140;
}

/// return opacity corresponding to elevation
double overlayOpacity(double elevation) =>
    (4.5 * math.log(elevation + 1) + 2) / 100.0;

///overlay color with elevation
Color colorElevated(Color color, double elevation) => Color.alphaBlend(
      getFontColor(color).withOpacity(overlayOpacity(elevation)),
      color,
    );

/// Class holding three different transition durations
class TransitionDuration {
  // constructor
  TransitionDuration(
    this._fast,
    this._normal,
    this._slow,
  );

  // get duration of fast transition
  Duration get fast => Duration(milliseconds: _fast);
  // get duration of fast transition
  Duration get normal => Duration(milliseconds: _normal);
  // get duration of fast transition
  Duration get slow => Duration(milliseconds: _slow);

  // length of duration in ms
  final int _fast;
  // length of duration in ms
  final int _normal;
  // length of duration in ms
  final int _slow;
}

class WraleTheme {
  WraleTheme(
      {required this.seedColor,
      required this.brightness,
      this.isAmoled = false});

  WraleTheme copyWith({
    Brightness? brightness,
    Color? seedColor,
    bool? isAmoled,
  }) {
    return WraleTheme(
      brightness: brightness ?? this.brightness,
      seedColor: seedColor ?? this.seedColor,
      isAmoled: isAmoled ?? this.isAmoled,
    );
  }

  /// seed color
  late Color seedColor;

  /// if dark mode on
  late Brightness brightness;

  /// if true make background true black
  late bool isAmoled;
}

// defining all workout difficulties
enum WraleCustomTheme {
  system,
  water,
  berry,
  sand,
  fire,
  lemon,
  forest,
  plum,
}

// extend adonisThemes with adonisTheme attributes
extension WraleCustomThemeExtension on WraleCustomTheme {
  // get seed color of theme
  Color seedColor(BuildContext context) => <WraleCustomTheme, Color>{
        WraleCustomTheme.system:
            Provider.of<WraleNotifier>(context).systemColorsAvailable
                ? Provider.of<WraleNotifier>(context).systemSeedColor
                : const Color(0xff000000),
        WraleCustomTheme.fire: const Color(0xffb52528),
        WraleCustomTheme.lemon: const Color(0xff626200),
        WraleCustomTheme.sand: const Color(0xff7e5700),
        WraleCustomTheme.water: const Color(0xff0161a3),
        WraleCustomTheme.forest: const Color(0xff006e11),
        WraleCustomTheme.berry: const Color(0xff8b4463),
        WraleCustomTheme.plum: const Color(0xff8e4585),
      }[this]!;

// get corresponding light theme
  WraleTheme light(BuildContext context) => WraleTheme(
        seedColor: seedColor(context),
        brightness: Brightness.light,
      );

// get corresponding dark theme

  WraleTheme dark(BuildContext context) => WraleTheme(
        seedColor: seedColor(context),
        brightness: Brightness.dark,
      );

// get amoled dark theme
  WraleTheme amoled(BuildContext context) => dark(context).amoled;

// get string expression
  String get name => toString().split('.').last;
}

//convert string to type
extension CustomThemeParsing on String {
  // convert number to difficulty
  WraleCustomTheme? toWraleCustomTheme() {
    for (final WraleCustomTheme theme in WraleCustomTheme.values) {
      if (this == theme.name) {
        return theme;
      }
    }
    return null;
  }
}

final List<ThemeMode> orderThemeModes = <ThemeMode>[
  ThemeMode.light,
  ThemeMode.system,
  ThemeMode.dark,
];

// convert string to ThemeMode
extension CustomThemeModeParsing on String {
  // convert string
  ThemeMode toThemeMode() => {
        'on': ThemeMode.dark,
        'off': ThemeMode.light,
        'auto': ThemeMode.system,
      }[this]!;
}
