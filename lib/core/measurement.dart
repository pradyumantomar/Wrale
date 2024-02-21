import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/notifier.dart';
import 'package:wrale/core/units.dart';

// class for weight event
@HiveType(typeId: 0)
class Measurement {
  //constructor
  Measurement({
    required this.weight,
    required this.date,
    this.isMeasured = false,
  });
  // weight of measurement
  @HiveField(0)
  final double weight;

// date of measurement
  @HiveField(1)
  final DateTime date;

// to store if measured
  final bool isMeasured;

  // copy with applying change

  Measurement apply({
    double? weight,
    DateTime? date,
    bool? isMeasured,
  }) =>
      Measurement(
        weight: weight ?? this.weight,
        date: date ?? this.date,
        isMeasured: isMeasured ?? this.isMeasured,
      );

  // implement sorting entries by date
  /// comparator method
  int compareTo(Measurement other) => date.compareTo(other.date);

  // check if identical
  bool isIdentical(Measurement other) =>
      (weight == other.weight) &&
      (date.difference(other.date).inMinutes.abs() <= 1);

  // return weight in active unit
  double inUnit(BuildContext context) {
    final scalingUnit =
        Provider.of<WraleNotifier>(context, listen: false).unit.scaling;

    return weight / scalingUnit;
  }

  // convert to String
  String weightToString(BuildContext context, {bool showUnit = true}) =>
      Provider.of<WraleNotifier>(context)
          .unit
          .measurementToString(this, showUnit = true);

  // convert date to String
  String dateToString(BuildContext context) =>
      Provider.of<WraleNotifier>(context, listen: false)
          .dateFormat(context)
          .format(date);

  // date followed by weight
  String measureToString(BuildContext context, {int ws = 10}) =>
      dateToString(context) + weightToString(context).padLeft(ws);

  // return day in milliseconds since epoch neglecting hours, minutes
  int get dayInMs =>
      DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;

  // return date in milliseconds
  int get dateInMs => date.millisecondsSinceEpoch;

  // return string for export
  String get exportString =>
      '${date.toIso8601String()} ${weight.toStringAsFixed(10)}';

  // copy with applying change
  static Measurement fromString({required String exportString}) {
    final List<String> strings = exportString.split(' ');

    if (strings.length != 2) {
      print('error with parsing measurement!');
    }

    return Measurement(
        weight: double.parse(strings[1]),
        date: DateTime.parse(strings[0]),
        isMeasured: true);
  }

  /// compare method to use default sort method on List
  static int compare(Measurement a, Measurement b) => a.compareTo(b);
}

class SortedMeasurement {
  // constructor
  SortedMeasurement({
    required this.key,
    required this.measurement,
  });

  //Measurement object
  final Measurement measurement;

  // Hive Key
  final dynamic key;

  // implementing sorting entries by date
  // comparator method
  int compareTo(SortedMeasurement other) =>
      measurement.date.compareTo(other.measurement.date);

  /// compare method to use default sort method on list
  static int compare(SortedMeasurement a, SortedMeasurement b) =>
      a.compareTo(b);
}
