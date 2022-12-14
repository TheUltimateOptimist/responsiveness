import 'package:flutter/material.dart' show Widget;

import '../breakpoint/breakpoints.dart';

class BuildData {
  const BuildData({
    required this.width,
    required this.breakpoints,
    required this.child,
  });
  
  final Widget child;
  final double width;
  final Breakpoints breakpoints;
}
