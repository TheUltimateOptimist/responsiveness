import 'generator.dart';
import 'screen_sizes.dart';

class ResponsiveValueGenerator implements Generator{
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    final firstName = screenSizes.names.first;
    final secondName = screenSizes.names[1];
    return """
///{@template responsive_value}
///It provides different values based on the current screen size.
///
///Use it when you want to specify differnt values for different screen sizes.
///
///The value of the screen size [$firstName] is mandatory, the other ones are optional.
///If you only provide a value for the screen size [$firstName], the given value will be used for all screen sizes.
///
///If you didn't provide a value for a screen size, the value from the next smaller defined screen size will be used.
///
///Added to the above, you can also provide [additionalValues] for custom screen sizes
///by giving the [additionalValues] parameter a map of key, value pairs.
///The key is the minimum width, for which the value will be used.
///
///[ResponsiveValue] could be used to apply different fontSizes for different screen sizes like so:
///```dart
///static const fontSize = ResponsiveValue<double>($firstName: 10, $secondName: 20);
///@override
///Widget build(BuildContext context){
///return Text(style: TextStyle(fontSize: fontSize.of(context)))
///}
///```
///In the above example, 10 would be used for the screen size $firstName and 20 would be used for the remaining screen sizes.
///{@endtemplate}
class ResponsiveValue<T>{
  ///{@macro responsive_value}
  const ResponsiveValue({
    required this.$firstName,
    this.additionalValues,
${_getConstructorParameters(screenSizes.names)}
  });

  ///the value to use for the screen size [$firstName]
  final T $firstName;

${_getClassFields(screenSizes)}

  ///holds additional values for screen sizes larger than the minimum width of the value's key
  final Map<int, T>? additionalValues;

  ///returns the right value for the current screen size
  T of(BuildContext context) {
    final values = _ValuesForAllScreenSizes(
${screenSizes.names.map((name) => "      $name:$name,").join("\n")}
      additionalValues: additionalValues,
    );
    return context.select<T>(values);
  }
}
""";
  }

  String _getConstructorParameters(List<String> names){
    String result = "";
    for(int i = 1; i < names.length; i++){
      result+="    this.${names[i]},\n";
    }
    return result;
  }

  String _getClassFields(ScreenSizes screenSizes){
    final names = screenSizes.names;
    final extendedNames = List<String>.empty(growable: true);
    for(int i = 1; i < names.length; i++){
      extendedNames.add("  ///the value to use for screen sizes >= ${screenSizes.minimumWidths[i]}\n  final T? ${names[i]};");
    }
    return extendedNames.join("\n\n");
  }
}