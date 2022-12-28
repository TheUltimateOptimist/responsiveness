import 'package:flutter/material.dart' show BuildContext;

import '../../internals/value_finder.dart';

///{@template raw_responsive_value}
///It provides different values based on the current screen size.
///
///You can extend this class to create a ResponsiveValue widget with custom screen sizes:
///```dart
/// class ResponsiveValue<T> extends RawResponsiveValue<T> {
///   const ResponsiveValue({required this.small, this.large});
///
///   final T small;
///   final T? large;
///
///   @override
///   List<T?> get values => [small, large];
/// }
///```
///{@endtemplate}
abstract class RawResponsiveValue<T> with ValueFinder<T> {
  const RawResponsiveValue();

  ///returns the right value for the current screen size
  T of(BuildContext context) {
    return find(context, values);
  }

  ///The length of the returned list has to match the number of different screen sizes of your application.
  ///
  ///The first element in the returned list can not be null.
  List<T?> get values;
}