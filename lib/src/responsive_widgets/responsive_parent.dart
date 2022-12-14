import 'package:flutter/material.dart'
    show Widget, StatelessWidget, BuildContext;

import '../internals/value_finder.dart';

///{@template responsive_parent}
///It wraps the given [child] with different [Widget]s based on the current screen size.
///
///Use it when you want to wrap an Object or subtree with different [Widget]s baded on the current screen size
///
///It needs to be given a [child]
///
///Added to that it takes 6 [Widget] returning functions which you can use to wrap the given [child] with the appropriate [Widget] baded on the current screen size.
///
///One or more of these 6 [Widget] returning functions need to be specified.
///
///If no function is given for a screen size the function of the nearest screen size will be used to obtain the widget to be built.
///
///If there are two nearest functions the one from the smaller screen size will be used.
///{@endtemplate}
class ResponsiveParent<T> extends StatelessWidget with ValueFinder {
  ///{@macro responsive_parent}
  ResponsiveParent({
    super.key,
    required this.child,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  ///The Object that should be wrapped with another [Widget] based on the current screen size
  final T child;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [xs]
  final Widget Function(T child)? xs;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [sm]
  final Widget Function(T child)? sm;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [md]
  final Widget Function(T child)? md;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [lg]
  final Widget Function(T child)? lg;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [xl]
  final Widget Function(T child)? xl;

  ///The function used to wrap the given [child] with another [Widget] for the screen size [xxl]
  final Widget Function(T child)? xxl;

  @override
  Widget build(BuildContext context) {
    return find(
      context,
      [
        xs != null ? xs!(child) : null,
        sm != null ? sm!(child) : null,
        md != null ? md!(child) : null,
        lg != null ? lg!(child) : null,
        xl != null ? xl!(child) : null,
        xxl != null ? xxl!(child) : null,
      ],
    );
  }
}
