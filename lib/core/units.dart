enum WraleUnit {
  kg,
  st,
  lb,
}

extension WraleUnitExtension on WraleUnit {
  double get scaling => <WraleUnit, double>{
        WraleUnit.kg: 1,
        WraleUnit.st: 6.35029318,
        WraleUnit.lb: 0.45359237,
      }[this]!;
}
