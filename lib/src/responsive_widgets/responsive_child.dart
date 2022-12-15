import 'package:flutter/material.dart'
    show Widget, StatelessWidget, BuildContext;

import '../internals/value_finder.dart';

///{@template responsive_child}
///It retuns different widgets based on the current screen size.
///
///Use it when you want to provide different [Widget]s based on the curren screen size.
///
///It takes 6 [Widget]s for the 6 different screen sizes [xs], [sm], [md], [lg], [xl], [xxl].
///One or more widgets need to be specified.
///If no widget is given for a screen size the widget of the nearest screen size will be used.
///If there are two nearest widgets the one from the smaller screen size will be used.
///{@endtemplate}
class ResponsiveChild extends StatelessWidget with ValueFinder<Widget> {
  ///{@macro responsive_child}
  const ResponsiveChild({
    super.key,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  ///the widget to use for the [xs] screen size
  final Widget? xs;

  ///the widget to use for the [sm] screen size
  final Widget? sm;

  ///the widget to use for the [md] screen size
  final Widget? md;

  ///the widget to use for the [lg] screen size
  final Widget? lg;

  ///the widget to use for the [xl] screen size
  final Widget? xl;

  ///the widget to use for the [xxl] screen size
  final Widget? xxl;

  @override
  Widget build(BuildContext context) {
    return find(context, [xs, sm, md, lg, xl, xxl]);
  }
}
