import 'package:flutter/material.dart'
    show Widget, StatelessWidget, BuildContext;

import "selector.dart";

///{@template responsive_parent}
///It wraps the given [child] with different [Widget]s based on the current screen size.
///
///Use it when you want to wrap an Object or subtree with different [Widget]s baded on the current screen size.
///
///It needs to be given a [child]
///
///Added to that it takes 6 [Widget] returning callbacks which you can use to wrap the given [child] with the appropriate [Widget] baded on the current screen size.
///
///The widget returning callback of the screen size [xs] is mandatory, the other ones are optional.
///If you only provide one for the screen size [xs], the given callback will be used for all screen sizes.
///
///If you also provide one for the screen size [lg] for example, the callback you provided for [xs] will be used for screen sizes [xs] - [lg] and the callback you provided for [lg] will be used for the screen sizes [lg] - [xxl].
///{@endtemplate}
class ResponsiveParent<T> extends StatelessWidget {
  ///{@macro responsive_parent}
  ResponsiveParent({
    super.key,
    required this.child,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  ///the Object that should be wrapped with another [Widget] based on the current screen size
  final T child;

  ///the callback used to wrap the given [child] with another [Widget] for the screen size [xs]
  final Widget Function(T child) xs;

  ///the callback used to wrap the given [child] with another [Widget] for the screen size [sm]
  final Widget Function(T child)? sm;

  ///the callback used to wrap the given [child] with another [Widget] for the screen size [md]
  final Widget Function(T child)? md;

  ///the callback used to wrap the given [child] with another [Widget] for the screen size [lg]
  final Widget Function(T child)? lg;

  ///the callback used to wrap the given [child] with another [Widget] for the screen size [xl]
  final Widget Function(T child)? xl;

  ///the callback used to wrap the given [child] with another [Widget] for the screen size [xxl]
  final Widget Function(T child)? xxl;

  @override
  Widget build(BuildContext context) {
    return context.select<Widget>([
      xs(child),
      sm != null ? sm!(child) : null,
      md != null ? md!(child) : null,
      lg != null ? lg!(child) : null,
      xl != null ? xl!(child) : null,
      xxl != null ? xxl!(child) : null,
    ]);
  }
}
