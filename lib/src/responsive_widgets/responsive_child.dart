import 'package:flutter/material.dart' show Widget;
import 'raw/raw_responsive_child.dart';

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
///{@endtemplate}
class ResponsiveChild extends RawResponsiveChild {
  ///{@macro responsive_child}
  const ResponsiveChild({
    super.key,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  ///the widget to use for the [xs] screen size
  final Widget xs;

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
  List<Widget?> get children => [xs, sm, md, lg, xl, xxl];
}
