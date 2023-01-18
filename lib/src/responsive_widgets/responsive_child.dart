import 'package:flutter/material.dart'
    show Widget, StatelessWidget, BuildContext;

import 'selector.dart';

///{@template responsive_child}
///It retuns different widgets based on the current screen size.
///
///Use it when you want to provide different [Widget]s based on the curren screen size.
///
///It takes 6 [Widget]s for the 6 different screen sizes [xs], [sm], [md], [lg], [xl], [xxl].
///The widget of the screen size [xs] is mandatory, the other ones are optional.
///If you only provide a widget for the screen size [xs], the given widget will be used for all screen sizes.
///
///If you also provide a widget for the screen size [lg] for example, the widget you provided for [xs] will be used for screen sizes [xs] - [lg] and the widget you provided for [lg] will be used for the screen sizes [lg] - [xxl].
///
///Added to the above, you can also provide [additionalWidgets] for custom screen sizes
///by giving the [additionalWidgets] parameter a map of key, value pairs.
///The key is the minimum width, for which the widget, provided as the
///corresponding value, will be used.
///{@endtemplate}
class ResponsiveChild extends StatelessWidget {
  ///{@macro responsive_child}
  const ResponsiveChild({
    this.additionalWidgets,
    super.key,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  ///the widget to use for screen sizes >= 0
  final Widget xs;

  ///the widget to use for screen sizes >= 576
  final Widget? sm;

  ///the widget to use for screen sizes >= 768
  final Widget? md;

  ///the widget to use for screen sizes >= 992
  final Widget? lg;

  ///the widget to use for screen sizes >= 1200
  final Widget? xl;

  ///the widget to use for screen sizes >= 1400
  final Widget? xxl;

  ///holds additional widgets for screen sizes larger than the minimum width of the widget's key
  final Map<int, Widget>? additionalWidgets;

  @override
  Widget build(BuildContext context) {
    final widgets = ValuesForAllScreenSizes(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      additionalValues: additionalWidgets,
    );
    return context.select<Widget>(widgets);
  }
}
