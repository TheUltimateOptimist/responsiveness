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
///It could be used to apply different fontSizes for different screen sizes like so:
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
${_getConstructorParameters(screenSizes.names)}
  });

  ///the value to use for the screen size [$firstName]
  final T $firstName;

${_getClassFields(screenSizes.names)}
  ///returns the right value for the current screen size
  T of(BuildContext context) {
    return context.select<T>([${screenSizes.names.join(', ')}]);
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

  String _getClassFields(List<String> names){
    String result = "";
    for(int i = 1; i < names.length; i++){
      result+="  ///the value to use for the screen size [${names[i]}]\n  final T? ${names[i]};\n\n";
    }
    return result;
  }
}