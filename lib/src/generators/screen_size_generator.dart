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
///### Screensizes:
${_generateScreenSizeTable(screenSizes)}
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
    throw Exception("Error: It was not possible to determine a ScreenSize for the current screen width");
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

  String _generateScreenSizeTable(ScreenSizes screenSizes) {
    const nameLength = 4;
    const nameAdditional = 17;
    int largestNameLength = nameLength;
    for (var name in screenSizes.names) {
      if (name.length > largestNameLength) {
        largestNameLength = name.length;
      }
    }
    final nameColumnLength = largestNameLength + nameAdditional;
    const indexColumnLength = 5;
    const minimumWidthColumnLength = 13;
    final tableRows = [
      "///|name${' ' * (nameColumnLength - nameLength)}|index|minimum width|",
      "///|:${'-' * (nameColumnLength - 2)}:|:${'-' * (indexColumnLength - 2)}:|:${'-' * (minimumWidthColumnLength - 2)}:|",
    ];
    for (int i = 0; i < screenSizes.names.length; i++) {
      final name = screenSizes.names[i];
      final minimumWidth = screenSizes.minimumWidths[i].toString();
      final index = i.toString();
      final nameColumn =
          "///|```ScreenSize.$name```${' ' * (largestNameLength - name.length)}|";
      final indexColumn = "$index${' ' * (indexColumnLength - index.length)}|";
      final minimumWidthColunn =
          "$minimumWidth${' ' * (minimumWidthColumnLength - minimumWidth.length)}|";
      tableRows.add(nameColumn + indexColumn + minimumWidthColunn);
    }
    return tableRows.join("\n");
  }
}
