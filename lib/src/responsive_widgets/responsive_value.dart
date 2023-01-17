import 'package:flutter/material.dart' show BuildContext;

import 'selector.dart';

///{@template responsive_value}
///It provides different values based on the current screen size.
///
///Use it when you want to specify differnt values for different screen sizes.
///
///The value of the screen size [xs] is mandatory, the other ones are optional.
///If you only provide a value for the screen size [xs], the given value will be used for all screen sizes.
///
///If you also provide a value for the screen size [lg] for example, the value you provided for [xs] will be used for screen sizes [xs] - [lg] and the value you provided for [lg] will be used for the screen sizes [lg] - [xxl].
///
///Added to the above, you can also provide [additionalValues] for custom screen sizes
///by giving the [additionalValues] parameter a map of key, value pairs.
///The key is the minimum width, for which the value will be used.
///
///[ResponsiveValue] could be used to apply different fontSizes for different screen sizes like so:
///```dart
///static const fontSize = ResponsiveValue<double>(xs: 10, md: 20);
///@override
///Widget build(BuildContext context){
///return Text(style: TextStyle(fontSize: fontSize.of(context)))
///}
///```
///In the above example, 10 would be used for the screen sizes xs, sm and 20 would be used for the screen sizes md, lg, xl, xxl.
///{@endtemplate}
class ResponsiveValue<T> {
  ///{@macro responsive_value}
  const ResponsiveValue({
    this.additionalValues,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  ///the value to use for the screen size [xs]
  final T xs;

  ///the value to use for the screen size [xs]
  final T? sm;

  ///the value to use for the screen size [xs]
  final T? md;

  ///the value to use for the screen size [xs]
  final T? lg;

  ///the value to use for the screen size [xs]
  final T? xl;

  ///the value to use for the screen size [xs]
  final T? xxl;

  ///holds additional values for screen sizes larger than the minimum width of the value's key
  final Map<int, T>? additionalValues;

  ///returns the right value for the current screen size
  T of(BuildContext context) {
    final values = ValuesForAllScreenSizes(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      additionalValues: additionalValues,
    );
    return context.select<T>(values);
  }
}
