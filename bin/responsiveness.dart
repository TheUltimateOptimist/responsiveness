import 'dart:io';

import 'package:responsiveness/src/generators/generators.dart';
import 'package:responsiveness/src/generators/screen_sizes.dart';

void main(List<String> args) {
  final root = Directory.current.path;
  final screenSizes = readScreenSizesFromJsonFile(root);
  final sourceCode = generateSourceCode(screenSizes);
  createSourceCodeFile(root, sourceCode);
}

ScreenSizes readScreenSizesFromJsonFile(String root){
  File file = File("$root/screen_sizes.json");
  return ScreenSizes.fromJsonString(file.readAsStringSync());
}

String generateSourceCode(ScreenSizes screenSizes){
  final generators = [
    GeneratedFileWarningGenerator(),
    DependencyGenerator(),
    ScreenSizeGenerator(),
    ResponsiveValueGenerator(),
    ResponsiveChildGenerator(),
    ResponsiveParentGenerator(),
    SelectorGenerator(),
  ];
  String sourceCode = "";
  for (var generator in generators) {
    sourceCode += generator.generateSourceCode(screenSizes);
    sourceCode += "\n";//seperates different sections in source code with an empty line
  }
  return sourceCode;
}

void createSourceCodeFile(String root, String sourceCode){
  File sourceCodeFile = File("$root/lib/responsiveness.dart");
  sourceCodeFile.createSync();
  sourceCodeFile.writeAsStringSync(sourceCode);
}
