import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:wrale/core/measurement.dart';
import 'package:wrale/main.dart';

// check if two integer  corresponds to same date
bool sameDay(DateTime? d1, DateTime? d2) {
  if (d1 == null || d2 == null) {
    return false;
  }

  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}

// check if a day already is in list
bool dayInMeasurements(
  DateTime d1,
  List measurements,
) {
  return <bool>[for (final m in measurements) sameDay(d1, m.date)]
      .reduce((bool value, bool element) => value || element);
}

/// class providing an API to handle measurements stored in hive

class MeasurementDatabase {
  // singleton constructor
  factory MeasurementDatabase() => _instance;

  // single instance creation
  MeasurementDatabase._internal();

  // singleton instance
  static final MeasurementDatabase _instance = MeasurementDatabase._internal();

  //box name
  static const String _boxName = measurementBoxName;

  // get box
  Box<Measurement> get box => Hive.box<Measurement>(_boxName);

  // broadcast steam to track changes in db
  final StreamController<List<Measurement>> _streamController =
      StreamController<List<Measurement>>.broadcast();

  //getter for broadcast steam to track changes in db
  StreamController<List<Measurement>> get streamController => _streamController;

  // check if measurement exists
  bool containMeasurement(Measurement a) {
    final List<bool> isMeasurement = <bool>[
      for (final Measurement measurement in []) measurement.isIdentical(a)
    ];
    return isMeasurement.contains(true);
  }
}
