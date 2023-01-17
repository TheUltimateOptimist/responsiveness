import 'screen_sizes.dart';

import "generator.dart";

class SelectorGenerator implements Generator {
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    return """
extension _Selector on BuildContext {
  T select<T>(_ValuesForAllScreenSizes<T> values) {
    final valuesWithTheirMinimumWidth = values._exportAllValues();
    valuesWithTheirMinimumWidth.sort(
      (a, b) => a.minimumWidth.compareTo(b.minimumWidth),
    );
    final screenWidth = MediaQuery.of(this).size.width;
    for (var valueForMinimumWidth in valuesWithTheirMinimumWidth.reversed) {
      if (screenWidth >= valueForMinimumWidth.minimumWidth &&
          valueForMinimumWidth.value != null) {
        return valueForMinimumWidth.value!;
      }
    }
    throw Exception(
        "Error: It was not possible to determine a value for the current screen size");
  }
}

class _ValuesForAllScreenSizes<T> {
  _ValuesForAllScreenSizes({
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    this.additionalValues,
  });

  final T xs;
  final T? sm;
  final T? md;
  final T? lg;
  final T? xl;
  final T? xxl;
  final Map<int, T>? additionalValues;

  List<_ValueForMinimumWidth<T>> _exportAllValues() {
    return _exportBasicValues() + _exportAdditionalValues();
  }

  List<_ValueForMinimumWidth<T>> _exportBasicValues() {
    return [
      _ValueForMinimumWidth<T>(
          minimumWidth: ScreenSize.xs.minimumWidth, value: xs),
      _ValueForMinimumWidth<T>(
          minimumWidth: ScreenSize.sm.minimumWidth, value: sm),
      _ValueForMinimumWidth<T>(
          minimumWidth: ScreenSize.md.minimumWidth, value: md),
      _ValueForMinimumWidth<T>(
          minimumWidth: ScreenSize.lg.minimumWidth, value: lg),
      _ValueForMinimumWidth<T>(
          minimumWidth: ScreenSize.xl.minimumWidth, value: xl),
      _ValueForMinimumWidth<T>(
          minimumWidth: ScreenSize.xxl.minimumWidth, value: xxl),
    ];
  }

  List<_ValueForMinimumWidth<T>> _exportAdditionalValues() {
    if (additionalValues == null) {
      return [];
    }
    return additionalValues!.entries
        .map(
          (mapEntry) => _ValueForMinimumWidth(
            minimumWidth: mapEntry.key,
            value: mapEntry.value,
          ),
        )
        .toList();
  }
}

class _ValueForMinimumWidth<T> {
  _ValueForMinimumWidth({
    required this.minimumWidth,
    this.value,
  });

  int minimumWidth;
  T? value;
}
""";
  }
}
