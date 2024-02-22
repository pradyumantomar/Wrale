import 'dart:math' as math;
import 'dart:ui';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/icons.dart';
import 'package:wrale/core/notifier.dart';
import 'package:wrale/main.dart';

// get color (black or white ) with maximal contrast or minimal (inverse = false)
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
  WraleTheme({
    required this.seedColor,
    required this.brightness,
    this.isAmoled = false,
  });

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

  // Get current Adonis Theme
  static WraleTheme? of(BuildContext context) {
    final WraleApp? result = context.findAncestorWidgetOfExactType<WraleApp>();
    return Theme.of(context).brightness == Brightness.light
        ? result?.wraleNotifier.theme.light(context)
        : (result != null && result.wraleNotifier.isAmoled)
            ? result.wraleNotifier.theme.amoled(context)
            : result?.wraleNotifier.theme.dark(context);
  }

  /// seed color
  late Color seedColor;

  /// if dark mode on
  late Brightness brightness;

  /// Border Shape
  final RoundedRectangleBorder borderShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );

  //Padding value
  final double padding = 16;

  /// if true make background true black
  late bool isAmoled;
  // get border radius
  double get borderRadius => 16;

  final TransitionDuration transitionDuration =
      TransitionDuration(100, 200, 500);

  /// get background gradient
  LinearGradient get bgGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[themeData.colorScheme.background, bgShade4],
      );

  // if dark mode enabled
  bool get isDark => brightness == Brightness.dark;

  // get elevated shade of color
  Color colorOfElevation(double elevation, Color color) => Color.alphaBlend(
        getFontColor(color).withOpacity(overlayOpacity(elevation)),
        color,
      );

  // elevation shade of bg
  Color get bgShade1 => bgElevated(24);
  Color get bgShade2 => bgElevated(6);
  Color get bgShade3 => bgElevated(2);
  Color get bgShade4 => bgElevated(1);

  // get elevated shade of bg
  Color bgElevated(double elevation) => colorOfElevation(
        elevation,
        themeData.colorScheme.background,
      );

  // get header color of dialog
  Color? get dialogHeaderColor => isDark
      ? colorElevated(
          themeData.dialogTheme.backgroundColor!,
          themeData.dialogTheme.elevation!,
        )
      : themeData.dialogTheme.backgroundColor;

  // get background color of dialog
  Color get dialogColor => isDark
      ? colorElevated(
          themeData.dialogTheme.backgroundColor!,
          themeData.dialogTheme.elevation! / 4,
        )
      : bgShade3;

  // get corresponding ThemeData
  ThemeData get themeData {
    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ).harmonized();
    if (isAmoled) {
      colorScheme = colorScheme.copyWith(background: Colors.black).harmonized();
    }

    // Create a TextTheme and ColorScheme,
    final TextTheme txtTheme = ThemeData.from(colorScheme: colorScheme)
        .textTheme
        .apply(fontFamily: 'QuickSand');

    final ListTileThemeData listTileThemeData = ListTileThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ));

    final ThemeData theme = ThemeData.from(
      colorScheme: colorScheme,
      textTheme: txtTheme,
      useMaterial3: true,
    ).copyWith(listTileTheme: listTileThemeData);

    // Return the themeData with materialApp can now use
    return theme;
  }

  // return amoled version with true black
  WraleTheme get amoled {
    return copyWith(isAmoled: true);
  }
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

// convert ThemeMode to String
extension CustomThemeModeEncoding on ThemeMode {
  // convert ThemeMode
  String toCustomString() => <ThemeMode, String>{
        ThemeMode.dark: 'on',
        ThemeMode.light: 'off',
        ThemeMode.system: 'auto'
      }[this]!;

  // get international name
  String nameLong(BuildContext context) => <ThemeMode, String>{
        ThemeMode.dark: AppLocalizations.of(context)!.darkmode,
        ThemeMode.light: AppLocalizations.of(context)!.lightmode,
        ThemeMode.system: AppLocalizations.of(context)!.systemmode,
      }[this]!;

  // get icon
  IconData get icon => <ThemeMode, IconData>{
        ThemeMode.light: CustomIcons.lightmode,
        ThemeMode.dark: CustomIcons.darkmode,
        ThemeMode.system: CustomIcons.automode,
      }[this]!;
}

// extension of theme
@immutable
class WraleThemeExtension extends ThemeExtension<WraleThemeExtension> {
  //constructor
  const WraleThemeExtension({
    required this.padding,
  });

  final double? padding;

// create getter for onPrimaryContainer textTheme
  TextTheme primaryContainerTextTheme(BuildContext context) =>
      Theme.of(context).textTheme.apply(
            bodyColor: Theme.of(context).colorScheme.onPrimary,
            displayColor: Theme.of(context).colorScheme.onPrimaryContainer,
            decorationColor: Theme.of(context).colorScheme.onPrimaryContainer,
          );

  @override
  ThemeExtension<WraleThemeExtension> copyWith({double? padding}) {
    return WraleThemeExtension(
      padding: padding ?? this.padding,
    );
  }

  @override
  ThemeExtension<WraleThemeExtension> lerp(
      covariant ThemeExtension<WraleThemeExtension>? other, double t) {
    if (other is! WraleThemeExtension) {
      return this;
    }
    return WraleThemeExtension(
      padding: lerpDouble(padding, other.padding, t),
    );
  }
}
