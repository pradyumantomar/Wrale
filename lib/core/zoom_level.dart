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
  }

  // get string extension
  String get name => toString().split('.').last;
}

/// convert units to string
extension ZoomLevelParsing on int {
  // convert number to difficulty
  ZoomLevel? toZoomLevel() =>
      this < ZoomLevel.values.length ? ZoomLevel.values[this] : null;
}
