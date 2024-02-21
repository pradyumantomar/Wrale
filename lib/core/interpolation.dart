/// class for interpolating measurement values
class Interpolation {}

enum InterpolStrength {
  // none
  none,
  // soft
  soft,
  // medium
  medium,
  // strong
  strong,
}

// extend interpolation strength
extension InterpolStrengthExtension on InterpolStrength {
  /// get the interpolation strength of measurements [days]
  double get strengthMeasurement => <InterpolStrength, double>{
        InterpolStrength.none: 0.01,
        InterpolStrength.soft: 2,
        InterpolStrength.medium: 4,
        InterpolStrength.strong: 7,
      }[this]!;

  /// get the interpolation strength of measurement[days]
  double get strengthInterpol => <InterpolStrength, double>{
        InterpolStrength.none: 0,
        InterpolStrength.soft: 1,
        InterpolStrength.medium: 2,
        InterpolStrength.strong: 3,
      }[this]!;
}
