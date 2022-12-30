import 'generator.dart';
import 'screen_sizes.dart';

class DependencyGenerator implements Generator{
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    return "import 'package:flutter/material.dart' show BuildContext, MediaQuery, Widget, StatelessWidget;\n";
  }
}