import 'package:shared_preferences/shared_preferences.dart';

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

  void loadDefaultSettings({bool override = false}) {}

  void resetSettings() => loadDefaultSettings(override: true);
}
