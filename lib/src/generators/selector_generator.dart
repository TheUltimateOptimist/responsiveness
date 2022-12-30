import 'screen_sizes.dart';

import "generator.dart";

class SelectorGenerator implements Generator {
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    return """
extension _Selector on BuildContext{
  T select<T>(List<T?> values){
    assert(values.length == ScreenSize.values.length, "The length of values list has to be equal to the number of different screen sizes");
    assert(values[0] != null, "The first element in the values list can not be null");
    final screenSizeIndex = ScreenSize.of(this).index;
    for (int i = screenSizeIndex; i >= 0; i--) {
      if (values[i] != null) {
        return values[i]!;
      }
    }
    throw Exception("Error: It was not possible to determine a value for the current screen size");
  }
}
""";
  }
}
