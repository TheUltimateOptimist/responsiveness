import 'package:flutter/material.dart' show BuildContext, MediaQuery;

///{@template screen_size}
///the current [ScreenSize] enum
///
///it can be retrived from the [BuildContext] using
///```dart
///ScreenSize.of(context)
///```
///it exposes the [index] and the [minimumWidth] of the current [ScreenSize]
///
///### Screensizes:
///|name                |index  |minimum width|devices         |
///|:------------------:|:-----:|:-----------:|:--------------:|
///|```ScreenSize.xs``` |0      |0            |portrait phones |
///|```ScreenSize.sm``` |1      |576          |landscape phones|
///|```ScreenSize.md``` |2      |768          |tablets         |
///|```ScreenSize.lg``` |3      |992          |destkops        |
///|```ScreenSize.xl``` |4      |1200         |large destkops  |
///|```ScreenSize.xxl```|5      |1400         |larger destkops |
///{@endtemplate}
enum ScreenSize{
  xs(0),
  sm(576),
  md(768),
  lg(992),
  xl(1200),
  xxl(1400);

  const ScreenSize(this.minimumWidth);

  ///{@template minimum_width}
  ///The [minimumWidth] field provides you with the minimum with of the [ScreenSize]
  ///
  ///for ScreenSize.xxl for example, [minimumWidth] will equal 1400
  ///{@endtemplate}
  final int minimumWidth;

  ///retrieves the current [ScreenSize] from the given [BuildContext]
  factory ScreenSize.of(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    for(final screenSize in ScreenSize.values.reversed){
      if(width >= screenSize.minimumWidth){
        return screenSize;
      }
    }
    throw Exception("Error: It was not possible to determine a ScreenSize for the current screen width");
  }
}
