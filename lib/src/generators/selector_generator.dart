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
${_getConstructorParameters(screenSizes.names)} 
    this.additionalValues,
  });

${getConstructorDeclarations(screenSizes.names)}
  final Map<int, T>? additionalValues;

  List<_ValueForMinimumWidth<T>> _exportAllValues() {
    return _exportBasicValues() + _exportAdditionalValues();
  }

  List<_ValueForMinimumWidth<T>> _exportBasicValues() {
    return [
${exportBasicValues(screenSizes.names)}      
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

  String _getConstructorParameters(List<String> names) {
    var result = "    required this.${names[0]},\n";
    for (int i = 1; i < names.length; i++) {
      result += "    this.${names[i]},\n";
    }
    return result.trimRight();
  }

  String getConstructorDeclarations(List<String> names) {
    var result = "  final T ${names[0]};\n";
    for (int i = 1; i < names.length; i++) {
      result += "  final T? ${names[i]};\n";
    }
    return result.trimRight();
  }

  String exportBasicValues(List<String> names) {
    var result = "";
    for (int i = 0; i < names.length; i++) {
      result +=
          "      _ValueForMinimumWidth<T>(minimumWidth: ScreenSize.${names[i]}.minimumWidth, value: ${names[i]}),\n";
    }
    return result.trimRight();
  }
}
