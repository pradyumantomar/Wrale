import 'package:flutter/material.dart';
import 'package:wrale/core/preferences.dart';

/// Class to dynamically change themeMode , isAmoled and language
/// within app
class WraleNotifier with ChangeNotifier {
  // empty constructor, in main.dart load preferences is called first
  WraleNotifier();

  /// call notifier
  void get notify => notifyListeners();

  /// shared preferences instance
  final Preferences prefs = Preferences();

  /// getter
}
