import 'generator.dart';
import 'screen_sizes.dart';

class ResponsiveParentGenerator implements Generator{
  @override
  String generateSourceCode(ScreenSizes screenSizes) {
    final numberOfScreenSizes = screenSizes.names.length;
    final firstName = screenSizes.names.first;
    return """
///{@template responsive_parent}
///It wraps the given [child] with different [Widget]s based on the current screen size.
///
///Use it when you want to wrap an Object or subtree with different [Widget]s baded on the current screen size.
///
///It needs to be given a [child].
///
///Added to that it takes $numberOfScreenSizes [Widget] returning callbacks which you can use to wrap the given [child] with the appropriate [Widget] baded on the current screen size.
///
///The widget returning callback for the screen size [$firstName] is mandatory, the other ones are optional.
///If you only provide one for the screen size [$firstName], the given callback will be used for all screen sizes.
///
///If you didn't provide a widget returning callback for a screen size, the one from the next smaller defined screen size will be used.
///
///Added to the above, you can also provide [additionalCallbacks] for custom screen sizes
///by giving the [additionalCallbacks] parameter a map of key, value pairs.
///The key is the minimum width, for which the callback, provided as the
///corresponding value, will be used.
///{@endtemplate}
class ResponsiveParent<T> extends StatelessWidget {
  ///{@macro responsive_parent}
  const ResponsiveParent({
    this.additionalCallbacks,
    super.key,
    required this.child,
    required this.$firstName,
${_getConstructorParameters(screenSizes.names)}
  });

  ///The Object that should be wrapped with another [Widget] based on the current screen size
  final T child;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [$firstName]
  final Widget Function(T child) $firstName;

${_getClassFields(screenSizes)}

  ///holds additional callbacks for screen sizes larger than the minimum width of the callback's key
  final Map<int, Widget Function(T child)>? additionalCallbacks;

  @override
  Widget build(BuildContext context) {
    final additionalWidgets = additionalCallbacks?.map(
      (key, value) => MapEntry(key, value(child)),
    );
    final widgets = _ValuesForAllScreenSizes(
      $firstName: $firstName(child),
${_getWidgets(screenSizes.names)}
      additionalValues: additionalWidgets,
    );
    return context.select<Widget>(widgets);
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

  String _getClassFields(ScreenSizes screenSizes) {
    final names = screenSizes.names;
    final extendedNames = List<String>.empty(growable: true);
    for (int i = 1; i < names.length; i++) {
      extendedNames.add("  ///The function used to wrap the given [child] with another [Widget] for screen sizes >= [${screenSizes.minimumWidths[i]}]\n  final Widget Function(T child)? ${names[i]};");
    }
    return extendedNames.join("\n\n");
  }

  String _getWidgets(List<String> names) {
    final extendedNames = List<String>.empty(growable: true);
    for (int i = 1; i < names.length; i++) {
      final name = names[i];
      extendedNames.add("      $name: $name != null ? $name!(child) : null,");
    }
    return extendedNames.join("\n");
  }  
}