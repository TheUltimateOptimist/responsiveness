import 'package:flutter/material.dart' show BuildContext;
import '../screen_size/screen_size.dart';

extension Selector on BuildContext{
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