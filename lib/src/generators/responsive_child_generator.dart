import 'generator.dart';
import 'screen_sizes.dart';

class ResponsiveChildGenerator implements Generator {
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    final numberOfScreenSizes = screenSizes.names.length;
    final firstName = screenSizes.names.first;
    return """
///{@template responsive_child}
///It retuns different widgets based on the current screen size.
///
///Use it when you want to provide different [Widget]s based on the curren screen size.
///
///It takes $numberOfScreenSizes [Widget]s for the $numberOfScreenSizes different screen sizes ${screenSizes.names.map((name) => '[$name]').join(', ')}.
///The widget of the screen size [$firstName] is mandatory, the other ones are optional.
///If you only provide a widget for the screen size [$firstName], the given widget will be used for all screen sizes.
///
///If you didn't provide a widget for a screen size, the widget from the next smaller defined screen size will be used.
///{@endtemplate}
class ResponsiveChild extends StatelessWidget{
  ///{@macro responsive_child}
  const ResponsiveChild({
    super.key,
    required this.$firstName,
${_getConstructorParameters(screenSizes.names)}
  });

  ///the widget to use for the screen size [$firstName]
  final Widget $firstName;

${_getClassFields(screenSizes.names)}
  @override
  Widget build(BuildContext context) {
    return context.select<Widget>([${screenSizes.names.join(', ')}]);
  }
}
""";
  }

  String _getConstructorParameters(List<String> names) {
    String result = "";
    for (int i = 1; i < names.length; i++) {
      result += "    this.${names[i]},\n";
    }
    return result;
  }

  String _getClassFields(List<String> names) {
    String result = "";
    for (int i = 1; i < names.length; i++) {
      result +=
          "  ///the widget to use for the screen size [${names[i]}]\n  final Widget? ${names[i]};\n\n";
    }
    return result;
  }
}
