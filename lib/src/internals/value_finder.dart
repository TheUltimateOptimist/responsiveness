import 'package:flutter/material.dart' show BuildContext;

import '../breakpoint/breakpoint.dart' show Breakpoint;

class _Distances {
  int leftDistance = 0;
  int rightDistance = 0;
}

mixin ValueFinder<T> {
  T find(
    BuildContext context,
    List<T?> values,
  ) {
    final startIndex = Breakpoint.of(context).index;
    final distances = _Distances();
    final leftValue = _findLeftValue(startIndex, values, distances);
    final rightValue = _findRightValue(startIndex, values, distances);
    if (leftValue != null && rightValue == null) return leftValue;
    if (rightValue != null && leftValue == null) return rightValue;
    assert(leftValue != null && rightValue != null);
    if (distances.leftDistance <= distances.rightDistance) {
      return leftValue!;
    }
    return rightValue!;
  }

  T? _findLeftValue(int index, List<T?> values, _Distances distances) {
    if (index == 0 || values[index] != null) {
      return values[index];
    }
    distances.leftDistance++;
    return _findLeftValue(--index, values, distances);
  }

  T? _findRightValue(int index, List<T?> values, _Distances distances) {
    if (index >= values.length - 1 || values[index] != null) {
      return values[index];
    }
    distances.rightDistance++;
    return _findRightValue(++index, values, distances);
  }
}
