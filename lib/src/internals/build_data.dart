import 'package:flutter/material.dart' show Widget;

import '../screen_size/minimum_widths.dart';

class BuildData {
  const BuildData({
    required this.width,
    required this.minimumWidths,
    required this.child,
  });

  final Widget child;
  final double width;
  final MinimumWidths minimumWidths;
}
