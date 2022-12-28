import 'package:responsiveness/src/responsive_widgets/raw/raw_responsive_value.dart';

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
class ResponsiveValue<T> extends RawResponsiveValue<T>{
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

  @override
  List<T?> get values => [xs, sm, md, lg, xl, xxl];
}
