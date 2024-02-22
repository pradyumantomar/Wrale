import 'package:wrale/core/database.dart';
import 'package:wrale/core/measurement.dart';

/// zoom level for line chart in [month]
enum ZoomLevel {
  two,
  six,
  year,
  all,
}

/// extend zoom levels
extension ZoomLevelExtension on ZoomLevel {
  //get the window length in month

  double get _rangeInMilliSeconds =>
      <ZoomLevel, int>{
        ZoomLevel.two: 2,
        ZoomLevel.six: 6,
        ZoomLevel.year: 12,
        ZoomLevel.all: -1,
      }[this]! *
      1000 *
      60 *
      60 *
      24 *
      30;

  // get range
  double get rangeInMilliSeconds => maxX - minX;

  //get next zoom  level
  ZoomLevel get next {
    final ZoomLevel nextLevel =
        ZoomLevel.values[(index + 1) % ZoomLevel.values.length];

// if range of measurements to short show all available
    if ((_measurements.last.dayInMs - _measurements.first.dayInMs).abs() <
        nextLevel._rangeInMilliSeconds) {
      return ZoomLevel.all;
    }
    return nextLevel;
  }

  /// get maxX value in [ms]
  double get maxX => _measurements.last.dayInMs.toDouble();

  /// get minX val in [ms]
  double get minX {
    if (this == ZoomLevel.all) {
      return _measurements.first.dayInMs.toDouble();
    }

    return _measurements.last.dayInMs - _rangeInMilliSeconds;
  }

  // get measurements to estimate range, maxX, and minX
  List<Measurement> get _measurements =>
      MeasurementDatabase().gaussianExtrapolatedMeasurements;

  // get string extension
  String get name => toString().split('.').last;
}

/// convert units to string
extension ZoomLevelParsing on int {
  // convert number to difficulty
  ZoomLevel? toZoomLevel() =>
      this < ZoomLevel.values.length ? ZoomLevel.values[this] : null;
}
