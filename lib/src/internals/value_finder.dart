import 'package:flutter/material.dart' show BuildContext;

import '../screen_size/screen_size.dart' show ScreenSize;

mixin ValueFinder<T> {
  T find(BuildContext context, List<T?> values) {
    assert(values.length == 6, "The length of the ValueFinder's values list has to be 6");
    assert(values[0] != null, "The first element in the values list can not be null");
    final screenSizeIndex = ScreenSize.of(context).index;
    for (int i = screenSizeIndex; i >= 0; i--) {
      if (values[i] != null) {
        return values[i]!;
      }
    }
    throw Exception("Internal error");
  }
}
