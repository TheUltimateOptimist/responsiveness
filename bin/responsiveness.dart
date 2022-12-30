import 'dart:io';

import 'package:responsiveness/src/generators/generators.dart';
import 'package:responsiveness/src/generators/screen_sizes.dart';

void main(List<String> args) {
  String root = Directory.current.path;
  File file = File("$root/screen_sizes.json");
  final screenSizes = ScreenSizes.fromJsonString(file.readAsStringSync());
  File generatedFile = File("$root/lib/responsiveness.dart");
  generatedFile.createSync();
  final generators = [
    GeneratedFileWarningGenerator(),
    DependencyGenerator(),
    ScreenSizeGenerator(),
    ResponsiveValueGenerator(),
    ResponsiveChildGenerator(),
    ResponsiveParentGenerator(),
    SelectorGenerator(),
  ];
  String output = "";
  for (var generator in generators) {
    output += generator.generateSourceCode(screenSizes);
    output += "\n";
  }
  generatedFile.writeAsStringSync(output);
}
