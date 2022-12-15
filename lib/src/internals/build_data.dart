import 'package:flutter/material.dart' show Widget;

import '../breakpoint/minimum_widths.dart';

class BuildData {
  const BuildData({
    required this.width,
    required this.screenSizes,
    required this.child,
  });

  final Widget child;
  final double width;
  final MinimumWidths screenSizes;
}
