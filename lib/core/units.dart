// Unit of weight measurements
import 'package:wrale/core/measurement.dart';

enum WraleUnit {
  kg,
  st,
  lb,
}

extension WraleUnitExtension on WraleUnit {
  /// get the scaling factor to kg
  double get scaling => <WraleUnit, double>{
        WraleUnit.kg: 1,
        WraleUnit.st: 6.35029318,
        WraleUnit.lb: 0.45359237,
      }[this]!;

  /// get the number of ticks
  int get ticksPerStep => <WraleUnit, int>{
        WraleUnit.kg: 10,
        WraleUnit.st: 20,
        WraleUnit.lb: 10,
      }[this]!;

  /// get the precision of ticks
  int get precision => <WraleUnit, int>{
        WraleUnit.kg: 1,
        WraleUnit.st: 2,
        WraleUnit.lb: 1,
      }[this]!;

  // convert weight of measurement to string
  String measurementToString(Measurement m, bool bool, {bool showUnit = true}) {
    return weightToString(m.weight, showUnit: showUnit);
  }

  // weight given in kg to string
  String weightToString(double weight, {bool showUnit = true}) {
    final String suffix = showUnit ? ' $name' : '';
    return '${doubleToPrecision(weight / scaling).toStringAsFixed(precision)}'
        '$suffix';
  }

  /// round double to given precision
  double doubleToPrecision(double val) =>
      (val * ticksPerStep).roundToDouble() / ticksPerStep;

  /// get string expression
  String get name => toString().split('.').last;
}

/// convert units to string
extension WraleUnitParsing on String {
  // convert number to difficulty
  WraleUnit? toWraleUnit() {
    for (final WraleUnit unit in WraleUnit.values) {
      if (this == unit.name) {
        return unit;
      }
    }
    return null;
  }
}
