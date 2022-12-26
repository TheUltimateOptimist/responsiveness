import 'package:flutter/material.dart' show BuildContext;

import '../internals/value_finder.dart';

///{@template responsive_value}
///It provides different values based on the current screen size.
///
///Use it when you want to specify differnt values for different screen sizes.
///
///One or more of the 6 different screen size parameters [xs], [sm], [md], [lg], [xl], [xxl] need to be specified.
///
///If no value is specified for a particular screen size parameter, the value from the nearest, defined screen size parameter will be used
///
///If there are two nearest, defined screen size parameters, the one from the smaller screen size will be used.
///
///It could be used to apply different fontSizes for different screen sizes like so:
///```dart
///static const fontSize = ResponsiveValue<double>(xs: 10, md: 20);
///@override
///Widget build(BuildContext context){
///return Text(style: TextStyle(fontSize: fontSize.of(context)))
///}
///```
///In the above example, 10 would be used for the screen sizes xs, sm and 20 would be used for the screen sizes md, lg, xl, xxl
///{@endtemplate}
class ResponsiveValue<T> with ValueFinder<T> {
  ///{@macro responsive_value}
  const ResponsiveValue({
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

  ///returns the right value for the current screen size
  T of(BuildContext context) {
    return find(context, [xs, sm, md, lg, xl, xxl]);
  }
}
