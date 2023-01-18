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
///
///Added to the above, you can also provide [additionalWidgets] for custom screen sizes
///by giving the [additionalWidgets] parameter a map of key, value pairs.
///The key is the minimum width, for which the widget, provided as the
///corresponding value, will be used.
///{@endtemplate}
class ResponsiveChild extends StatelessWidget{
  ///{@macro responsive_child}
  const ResponsiveChild({
    super.key,
    this.additionalWidgets,
    required this.$firstName,
${_getConstructorParameters(screenSizes.names)}
  });

  ///the widget to use for the screen size [$firstName]
  final Widget $firstName;

${_getClassFields(screenSizes)}

  ///holds additional widgets for screen sizes larger than the minimum width of the widget's key
  final Map<int, Widget>? additionalWidgets;

  @override
  Widget build(BuildContext context) {
    final widgets = _ValuesForAllScreenSizes(
${screenSizes.names.map((name) => "      $name:$name,").join("\n")}
      additionalValues: additionalWidgets,
    );
    return context.select<Widget>(widgets);
  }
}
""";
  }

  String _getConstructorParameters(List<String> names) {
    var result = "";
    for (int i = 1; i < names.length; i++) {
      result += "    this.${names[i]},\n";
    }
    return result;
  }

  String _getClassFields(ScreenSizes screenSizes) {
    final names = screenSizes.names;
    final extendedNames = List<String>.empty(growable: true);
    for (int i = 1; i < names.length; i++) {
      extendedNames.add("  ///the widget to use for screen sizes >= ${screenSizes.minimumWidths[i]}\n  final Widget? ${names[i]};");
    }
    return extendedNames.join("\n\n");
  }
}
