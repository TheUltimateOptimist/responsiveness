import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        BuildContext,
        MediaQuery,
        Container,
        InheritedWidget;
import 'minimum_widths.dart';
import '../internals/build_data.dart';

export 'minimum_widths.dart';
part 'screen_size_provider.dart';

///{@template screen_size}
///the current [ScreenSize]
///
///it can be retrived from the [BuildContext] using
///```dart
///Breakpoint.of(context)
///```
///it exposes the [index] and the [minimumWidth] of the current [ScreenSize]
///
///{@endtemplate}
///{@macro index}
///{@macro minimum_width}
class ScreenSize extends InheritedWidget {
  ///{@macro screen_size}
  ///{@macro index}
  ///{@macro minimum_width}
  ScreenSize(this.index, this.minimumWidth, {required super.child});

  ///the index of the current [ScreenSize]
  ///
  ///{@template index}
  ///the [index] can range from 0 to 5: xs -> 0, sm -> 1, md -> 2, lg -> 3, xl -> 4, xxl -> 5
  ///
  ///using the [index] you can do something like:
  ///```dart
  ///if(ScreenSize.of(context).index == ScreenSize.xs){
  ///
  ///}
  ///```
  ///or
  ///```dart
  ///switch(ScreenSize.of(context).index){
  ///   case ScreenSize.xs: throw UnimplementedError();
  ///   case ScreenSize.sm: throw UnimplementedError();
  ///   case ScreenSize.md: throw UnimplementedError();
  ///   case ScreenSize.lg: throw UnimplementedError();
  ///   case ScreenSize.xl: throw UnimplementedError();
  ///   case ScreenSize.xxl: throw UnimplementedError();
  /// }
  ///```
  ///{@endtemplate}
  final int index;

  ///{@template minimum_width}
  ///The [minimumWidth] field provides you with the minimum with of the current [ScreenSize]
  ///
  ///if for example [xxl] is the current [ScreenSize], [minimumWidth] will equal 1400, unless different minimum widths
  ///were specified in the [ScreenSizeProvider] that sits on top of the widget tree
  ///{@endtemplate}
  final int minimumWidth;

  ///index of the [ScreenSize] [xs]
  static const xs = 0;

  ///index of the [ScreenSize] [sm]
  static const sm = 1;

  ///index of the [ScreenSize] [md]
  static const md = 2;

  ///index of the [ScreenSize] [lg]
  static const lg = 3;

  ///index of the [ScreenSize] [xl]
  static const xl = 4;

  ///index of the [ScreenSize] [xxl]
  static const xxl = 5;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return index != (oldWidget as ScreenSize).index;
  }

  ///retrieves the current [ScreenSize] from the given [BuildContext]
  factory ScreenSize.of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ScreenSize>();
    assert(result != null,
        "No Breakpoint found in context. Please make sure to add the BreakpointProvider at the top of your widget tree");
    return result as ScreenSize;
  }

  factory ScreenSize._fromBuildData(BuildData buildData) {
    if (buildData.width >= buildData.minimumWidths.xxl) {
      return ScreenSize(ScreenSize.xxl, buildData.minimumWidths.xxl,
          child: buildData.child);
    }
    if (buildData.width >= buildData.minimumWidths.xl) {
      return ScreenSize(ScreenSize.xl, buildData.minimumWidths.xl,
          child: buildData.child);
    }
    if (buildData.width >= buildData.minimumWidths.lg) {
      return ScreenSize(ScreenSize.lg, buildData.minimumWidths.lg,
          child: buildData.child);
    }
    if (buildData.width >= buildData.minimumWidths.md) {
      return ScreenSize(ScreenSize.md, buildData.minimumWidths.md,
          child: buildData.child);
    }
    if (buildData.width >= buildData.minimumWidths.sm) {
      return ScreenSize(ScreenSize.sm, buildData.minimumWidths.sm,
          child: buildData.child);
    }
    return ScreenSize(ScreenSize.xs, buildData.minimumWidths.xs,
        child: buildData.child);
  }
}
