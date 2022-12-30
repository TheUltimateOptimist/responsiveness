import 'screen_sizes.dart';
import 'generator.dart';

class ScreenSizeGenerator implements Generator {
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    return """
///{@template screen_size}
///the current [ScreenSize] enum
///
///it can be retrived from the [BuildContext] using
///```dart
///ScreenSize.of(context)
///```
///it exposes the [index] and the [minimumWidth] of the current [ScreenSize]
///
///{@endtemplate}
enum ScreenSize{
${_generateNames(screenSizes)}
  const ScreenSize(this.minimumWidth);

  ///{@template minimum_width}
  ///The [minimumWidth] field provides you with the minimum with of the [ScreenSize]
  ///
  ///for ScreenSize.${screenSizes.names.last} for example, [minimumWidth] will equal ${screenSizes.minimumWidths.last}
  ///{@endtemplate}
  final int minimumWidth;

  ///retrieves the current [ScreenSize] from the given [BuildContext]
  factory ScreenSize.of(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    for(final screenSize in ScreenSize.values.reversed){
      if(width >= screenSize.minimumWidth){
        return screenSize;
      }
    }
    throw Exception("Error: It was not possible to determine a ScreenSize for the curren screen width");
  }
}
""";
  }

  String _generateNames(ScreenSizes screenSizes) {
    String result = "";
    for (int i = 0; i < screenSizes.names.length; i++) {
      final name = screenSizes.names[i];
      final minimumWidth = screenSizes.minimumWidths[i];
      result += "  $name($minimumWidth)";
      if (i == screenSizes.names.length - 1) {
        result += ";";
      } else {
        result += ",";
      }
      result += "\n";
    }
    return result;
  }
}
