import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/notifier.dart';

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
