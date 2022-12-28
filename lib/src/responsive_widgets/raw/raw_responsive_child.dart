import 'package:flutter/material.dart'
    show Widget, StatelessWidget, BuildContext;

import '../../internals/value_finder.dart';

///{@template raw_responsive_child}
///It builds different widgets based on the current screen size.
///
///You can extend this class to create a ResponsiveChild widget with custom screen sizes:
///```dart
///class ResponsiveChild extends RawResponsiveChild{
///  const ResponsiveChild({super.key, required this.small, this.large});
///
///  final Widget small;
///  final Widget? large;
///
///  @override
///  List<Widget?> get children => [small, large];
///  }
///}
///```
///{@endtemplate}
abstract class RawResponsiveChild extends StatelessWidget
    with ValueFinder<Widget> {
  ///{@macro raw_responsive_child}
  const RawResponsiveChild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return find(context, children);
  }

  ///The length of the returned list has to match the number of different screen sizes of your application.
  ///
  ///The first element in the returned list can not be null.
  List<Widget?> get children;
}
