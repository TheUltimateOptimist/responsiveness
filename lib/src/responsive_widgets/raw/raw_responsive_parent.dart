import 'package:flutter/material.dart'
    show Widget, StatelessWidget, BuildContext;

import '../../internals/value_finder.dart';

///{@template raw_responsive_parent}
///It wraps the given [child] with different [Widget]s based on the current screen size.
///
///It needs to be given a [child]
///
///You can extend this class to create a ResponsiveParent widget with custom screen sizes:
///```dart
///class ResponsiveParent<T> extends RawResponsiveParent<T> {
///  const ResponsiveParent({required super.child, required this.small, this.large});
//
///  final Widget Function(T child) small;
///  final Widget Function(T child)? large;
//
///  @override
///  List<Widget Function(T child)?> get children => [small, large];
///}
///```
///{@endtemplate}
abstract class RawResponsiveParent<T> extends StatelessWidget with ValueFinder {
  ///{@macro raw_responsive_parent}
  const RawResponsiveParent({
    super.key,
    required this.child,
  });

  ///the Object that should be wrapped with another [Widget] based on the current screen size
  final T child;

  ///The length of the returned list has to match the number of different screen sizes of your application.
  ///
  ///The first element in the returned list can not be null.
  List<Widget Function(T child)?> get children;

  @override
  Widget build(BuildContext context) {
    return find(
      context,
      [
        for (final childCallback in children)
          childCallback != null ? childCallback(child) : null
      ],
    );
  }
}
