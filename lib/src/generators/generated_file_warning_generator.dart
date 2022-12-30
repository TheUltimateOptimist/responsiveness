import 'generator.dart';
import 'screen_sizes.dart';

class GeneratedFileWarningGenerator implements Generator{
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    return  "// GENERATED CODE - DO NOT MODIFY BY HAND\n";
  }
}