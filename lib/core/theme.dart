import 'package:flutter/material.dart';

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
